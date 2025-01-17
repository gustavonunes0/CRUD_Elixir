defmodule FinancialManagerWeb.ExpenseControllerTest do
  use FinancialManagerWeb.ConnCase

  import FinancialManager.FinancesFixtures

  @create_attrs %{value: "120.5", date: ~D[2024-12-02], description: "some description"}
  @update_attrs %{value: "456.7", date: ~D[2024-12-03], description: "some updated description"}
  @invalid_attrs %{value: nil, date: nil, description: nil}

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, ~p"/expenses")
      assert html_response(conn, 200) =~ "Listing Expenses"
    end
  end

  describe "new expense" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/expenses/new")
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "create expense" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expense: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/expenses/#{id}"

      conn = get(conn, ~p"/expenses/#{id}")
      assert html_response(conn, 200) =~ "Expense #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "edit expense" do
    setup [:create_expense]

    test "renders form for editing chosen expense", %{conn: conn, expense: expense} do
      conn = get(conn, ~p"/expenses/#{expense}/edit")
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "redirects when data is valid", %{conn: conn, expense: expense} do
      conn = put(conn, ~p"/expenses/#{expense}", expense: @update_attrs)
      assert redirected_to(conn) == ~p"/expenses/#{expense}"

      conn = get(conn, ~p"/expenses/#{expense}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put(conn, ~p"/expenses/#{expense}", expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete(conn, ~p"/expenses/#{expense}")
      assert redirected_to(conn) == ~p"/expenses"

      assert_error_sent 404, fn ->
        get(conn, ~p"/expenses/#{expense}")
      end
    end
  end

  defp create_expense(_) do
    expense = expense_fixture()
    %{expense: expense}
  end
end
