defmodule FinancialManager.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :value, :decimal
    field :date, :date
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:date, :value, :description])
    |> validate_required([:date, :value, :description])
  end
end
