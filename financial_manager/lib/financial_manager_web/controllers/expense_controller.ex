import Ecto.Query

defmodule FinancialManagerWeb.ExpenseController do
  use FinancialManagerWeb, :controller
  alias FinancialManager.Finances
  alias FinancialManager.Finances.Expense

  # Listar todas as despesas
  def index(conn, %{"month" => month}) when month != "" do
    month_number = String.to_integer(month)
    expenses = Finances.list_expenses_by_month(month_number)
    render(conn, "index.html", expenses: expenses)
  end

  # Listar despesas por período
  def index(conn, %{"start_date" => start_date, "end_date" => end_date}) do
    expenses = Finances.list_expenses_by_period(start_date, end_date)
    render(conn, "index.html", expenses: expenses)
  end

  # Listar maiores receitas
  def index(conn, %{"type" => "maiores"}) do
    expenses = Finances.list_largest_expenses(:desc)
    render(conn, "index.html", expenses: expenses)
  end

  # Listar menores receitas
  def index(conn, %{"type" => "menores"}) do
    expenses = Finances.list_smallest_expenses(:asc)
    render(conn, "index.html", expenses: expenses)
  end

  # Caso nenhum parâmetro seja passado, listamos todas as despesas
  def index(conn, _params) do
    expenses = Finances.list_expenses()
    render(conn, "index.html", expenses: expenses)
  end

  # Exibir o formulário de criação
  def new(conn, _params) do
    changeset = Finances.change_expense(%Expense{})
    render(conn, "new.html", changeset: changeset)
  end

  # Criar uma nova despesa
  def create(conn, %{"expense" => expense_params}) do
    case Finances.create_expense(expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Despesa criada com sucesso.")
        |> redirect(to: "/expenses")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # Exibir uma despesa
  def show(conn, %{"id" => id}) do
    expense = Finances.get_expense!(id)
    render(conn, "show.html", expense: expense)
  end

  # Exibir o formulário de edição
  def edit(conn, %{"id" => id}) do
    expense = Finances.get_expense!(id)
    changeset = Finances.change_expense(expense)
    render(conn, "edit.html", expense: expense, changeset: changeset)
  end

  # Atualizar uma despesa
  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Finances.get_expense!(id)

    case Finances.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Despesa atualizada com sucesso.")
        |> redirect(to: "/expenses")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expense: expense, changeset: changeset)
    end
  end

  # Excluir uma despesa
  def delete(conn, %{"id" => id}) do
    expense = Finances.get_expense!(id)
    {:ok, _expense} = Finances.delete_expense(expense)

    conn
    |> put_flash(:info, "Despesa excluída com sucesso.")
    |> redirect(to: "/expenses")
  end
end
