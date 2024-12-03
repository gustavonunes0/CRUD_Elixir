defmodule FinancialManager.Repo.Migrations.CreateRevenues do
  use Ecto.Migration

  def change do
    create table(:revenues) do
      add :date, :date
      add :value, :decimal
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
