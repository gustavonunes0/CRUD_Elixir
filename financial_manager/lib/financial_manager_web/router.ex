defmodule FinancialManagerWeb.Router do
  use FinancialManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FinancialManagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FinancialManagerWeb do
    pipe_through :browser

    # Página inicial
    get "/", PageController, :home

    # Rotas para o CRUD de receitas
    resources "/revenues", RevenueController

    # Gráfico de receitas mensais
    get "/revenues/monthly_chart", RevenueController, :monthly_chart

    # Rotas para o CRUD de despesas
    resources "/expenses", ExpenseController
  end

  if Application.compile_env(:financial_manager, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FinancialManagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
