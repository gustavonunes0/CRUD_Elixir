defmodule FinancialManager.Finances.Revenue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "revenues" do
    field :date, :date
    field :value, :decimal
    field :description, :string
    # Adicione outros campos conforme necessário

    timestamps()
  end

  def changeset(revenue, attrs) do
    revenue
    |> cast(attrs, [:date, :value, :description])
    |> validate_required([:date, :value])
  end
end
