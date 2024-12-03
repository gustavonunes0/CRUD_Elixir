defmodule FinancialManager.Finances.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :value, :decimal
    field :description, :string
    field :date, :date

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:value, :description, :date])
    |> validate_required([:value, :description, :date])
  end
end
