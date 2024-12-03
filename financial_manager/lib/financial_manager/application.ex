defmodule FinancialManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FinancialManagerWeb.Telemetry,
      FinancialManager.Repo,
      {DNSCluster, query: Application.get_env(:financial_manager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FinancialManager.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FinancialManager.Finch},
      # Start a worker by calling: FinancialManager.Worker.start_link(arg)
      # {FinancialManager.Worker, arg},
      # Start to serve requests, typically the last entry
      FinancialManagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FinancialManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FinancialManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
