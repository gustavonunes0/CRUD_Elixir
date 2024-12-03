defmodule FinancialManagerWeb.RevenueControllerTest do
  use FinancialManagerWeb.ConnCase

  import FinancialManager.FinancesFixtures

  @create_attrs %{value: "120.5", date: ~D[2024-12-02], description: "some description"}
  @update_attrs %{value: "456.7", date: ~D[2024-12-03], description: "some updated description"}
  @invalid_attrs %{value: nil, date: nil, description: nil}

  describe "index" do
    test "lists all revenues", %{conn: conn} do
      conn = get(conn, ~p"/revenues")
      assert html_response(conn, 200) =~ "Listing Revenues"
    end
  end

  describe "new revenue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/revenues/new")
      assert html_response(conn, 200) =~ "New Revenue"
    end
  end

  describe "create revenue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/revenues", revenue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/revenues/#{id}"

      conn = get(conn, ~p"/revenues/#{id}")
      assert html_response(conn, 200) =~ "Revenue #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/revenues", revenue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Revenue"
    end
  end

  describe "edit revenue" do
    setup [:create_revenue]

    test "renders form for editing chosen revenue", %{conn: conn, revenue: revenue} do
      conn = get(conn, ~p"/revenues/#{revenue}/edit")
      assert html_response(conn, 200) =~ "Edit Revenue"
    end
  end

  describe "update revenue" do
    setup [:create_revenue]

    test "redirects when data is valid", %{conn: conn, revenue: revenue} do
      conn = put(conn, ~p"/revenues/#{revenue}", revenue: @update_attrs)
      assert redirected_to(conn) == ~p"/revenues/#{revenue}"

      conn = get(conn, ~p"/revenues/#{revenue}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, revenue: revenue} do
      conn = put(conn, ~p"/revenues/#{revenue}", revenue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Revenue"
    end
  end

  describe "delete revenue" do
    setup [:create_revenue]

    test "deletes chosen revenue", %{conn: conn, revenue: revenue} do
      conn = delete(conn, ~p"/revenues/#{revenue}")
      assert redirected_to(conn) == ~p"/revenues"

      assert_error_sent 404, fn ->
        get(conn, ~p"/revenues/#{revenue}")
      end
    end
  end

  defp create_revenue(_) do
    revenue = revenue_fixture()
    %{revenue: revenue}
  end
end
