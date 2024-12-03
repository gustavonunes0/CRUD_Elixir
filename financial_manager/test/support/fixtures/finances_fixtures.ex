defmodule FinancialManager.FinancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FinancialManager.Finances` context.
  """

  @doc """
  Generate a revenue.
  """
  def revenue_fixture(attrs \\ %{}) do
    {:ok, revenue} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-12-02],
        description: "some description",
        value: "120.5"
      })
      |> FinancialManager.Finances.create_revenue()

    revenue
  end

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-12-02],
        description: "some description",
        value: "120.5"
      })
      |> FinancialManager.Finances.create_expense()

    expense
  end
end
