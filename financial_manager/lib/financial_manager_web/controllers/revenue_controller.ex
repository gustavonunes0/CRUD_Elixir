import Ecto.Query
defmodule FinancialManagerWeb.RevenueController do
  use FinancialManagerWeb, :controller
  alias FinancialManager.Finances
  alias FinancialManager.Finances.Revenue

  def monthly_chart(conn, _params) do
    # Buscando receitas organizadas por mês
    revenues_by_month = Finances.list_monthly_revenues()

    # Renderizando o template com os dados
    render(conn, "monthly_chart.html", revenues_by_month: revenues_by_month)
  end

  # Listar todas as receitas
  def index(conn, %{"month" => month}) when month != "" do
    month_number = String.to_integer(month)
    revenues = Finances.list_revenues_by_month(month_number)
    render(conn, "index.html", revenues: revenues)
  end

  # Listar maiores receitas
  def index(conn, %{"type" => "maiores"}) do
    revenues = Finances.list_largest_revenues(:desc)
    render(conn, "index.html", revenues: revenues)
  end

  # Listar menores receitas
  def index(conn, %{"type" => "menores"}) do
    revenues = Finances.list_smallest_revenues(:asc)
    render(conn, "index.html", revenues: revenues)
  end

  def index(conn, params) do
    revenues =
      cond do
        params["month"] ->
          Finances.list_revenues_by_month(String.to_integer(params["month"]))

        params["start_date"] && params["end_date"] ->
          Finances.list_revenues_by_period(params["start_date"], params["end_date"])

        true ->
          Finances.list_revenues()
      end

    render(conn, "index.html", revenues: revenues)
  end

  def index(conn, _params) do
    revenues = Finances.list_revenues()
    render(conn, "index.html", revenues: revenues)
  end

  # Exibir o formulário de criação
  def new(conn, _params) do
    changeset = Finances.change_revenue(%Revenue{})
    render(conn, "new.html", changeset: changeset)
  end

  # Criar uma nova receita
  def create(conn, %{"revenue" => revenue_params}) do
    case Finances.create_revenue(revenue_params) do
      {:ok, revenue} ->
        conn
        |> put_flash(:info, "Receita criada com sucesso.")
        |> redirect(to: "/revenues")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Exibir uma receita
  def show(conn, %{"id" => id}) do
    revenue = Finances.get_revenue!(id)
    render(conn, "show.html", revenue: revenue)
  end

  # Exibir o formulário de edição
  def edit(conn, %{"id" => id}) do
    revenue = Finances.get_revenue!(id)
    changeset = Finances.change_revenue(revenue)
    render(conn, "edit.html", revenue: revenue, changeset: changeset)
  end

  # Atualizar uma receita
  def update(conn, %{"id" => id, "revenue" => revenue_params}) do
    revenue = Finances.get_revenue!(id)

    case Finances.update_revenue(revenue, revenue_params) do
      {:ok, revenue} ->
        conn
        |> put_flash(:info, "Receita atualizada com sucesso.")
        |> redirect(to: "/revenues")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", revenue: revenue, changeset: changeset)
    end
  end

  # Excluir uma receita
  def delete(conn, %{"id" => id}) do
    revenue = Finances.get_revenue!(id)
    {:ok, _revenue} = Finances.delete_revenue(revenue)

    conn
    |> put_flash(:info, "Receita excluída com sucesso.")
    |> redirect(to: "/revenues")
  end
end
