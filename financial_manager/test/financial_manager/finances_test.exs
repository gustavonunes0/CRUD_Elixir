defmodule FinancialManager.FinancesTest do
  use FinancialManager.DataCase

  alias FinancialManager.Finances

  describe "revenues" do
    alias FinancialManager.Finances.Revenue

    import FinancialManager.FinancesFixtures

    @invalid_attrs %{value: nil, date: nil, description: nil}

    test "list_revenues/0 returns all revenues" do
      revenue = revenue_fixture()
      assert Finances.list_revenues() == [revenue]
    end

    test "get_revenue!/1 returns the revenue with given id" do
      revenue = revenue_fixture()
      assert Finances.get_revenue!(revenue.id) == revenue
    end

    test "create_revenue/1 with valid data creates a revenue" do
      valid_attrs = %{value: "120.5", date: ~D[2024-12-02], description: "some description"}

      assert {:ok, %Revenue{} = revenue} = Finances.create_revenue(valid_attrs)
      assert revenue.value == Decimal.new("120.5")
      assert revenue.date == ~D[2024-12-02]
      assert revenue.description == "some description"
    end

    test "create_revenue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_revenue(@invalid_attrs)
    end

    test "update_revenue/2 with valid data updates the revenue" do
      revenue = revenue_fixture()
      update_attrs = %{value: "456.7", date: ~D[2024-12-03], description: "some updated description"}

      assert {:ok, %Revenue{} = revenue} = Finances.update_revenue(revenue, update_attrs)
      assert revenue.value == Decimal.new("456.7")
      assert revenue.date == ~D[2024-12-03]
      assert revenue.description == "some updated description"
    end

    test "update_revenue/2 with invalid data returns error changeset" do
      revenue = revenue_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_revenue(revenue, @invalid_attrs)
      assert revenue == Finances.get_revenue!(revenue.id)
    end

    test "delete_revenue/1 deletes the revenue" do
      revenue = revenue_fixture()
      assert {:ok, %Revenue{}} = Finances.delete_revenue(revenue)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_revenue!(revenue.id) end
    end

    test "change_revenue/1 returns a revenue changeset" do
      revenue = revenue_fixture()
      assert %Ecto.Changeset{} = Finances.change_revenue(revenue)
    end
  end

  describe "expenses" do
    alias FinancialManager.Finances.Expense

    import FinancialManager.FinancesFixtures

    @invalid_attrs %{value: nil, date: nil, description: nil}

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert Finances.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert Finances.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      valid_attrs = %{value: "120.5", date: ~D[2024-12-02], description: "some description"}

      assert {:ok, %Expense{} = expense} = Finances.create_expense(valid_attrs)
      assert expense.value == Decimal.new("120.5")
      assert expense.date == ~D[2024-12-02]
      assert expense.description == "some description"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      update_attrs = %{value: "456.7", date: ~D[2024-12-03], description: "some updated description"}

      assert {:ok, %Expense{} = expense} = Finances.update_expense(expense, update_attrs)
      assert expense.value == Decimal.new("456.7")
      assert expense.date == ~D[2024-12-03]
      assert expense.description == "some updated description"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_expense(expense, @invalid_attrs)
      assert expense == Finances.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = Finances.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = Finances.change_expense(expense)
    end
  end
end
