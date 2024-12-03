defmodule FinancialManager.Revenue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "revenues" do
    field :value, :decimal
    field :date, :date
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(revenue, attrs) do
    revenue
    |> cast(attrs, [:date, :value, :description])
    |> validate_required([:date, :value, :description])
  end
end
