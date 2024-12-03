defmodule FinancialManager.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :date, :date
      add :value, :decimal
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
