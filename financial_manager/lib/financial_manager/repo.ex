defmodule FinancialManager.Repo do
  use Ecto.Repo,
    otp_app: :financial_manager,
    adapter: Ecto.Adapters.Postgres
end
