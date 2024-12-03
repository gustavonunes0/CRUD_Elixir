defmodule FinancialManager.Finances do
  import Ecto.Query, only: [from: 2, order_by: 2, limit: 2, fragment: 2]

  alias FinancialManager.Repo
  alias FinancialManager.Finances.Revenue
  alias FinancialManager.Finances.Expense

  # Função para listar todas as receitas
  def list_revenues do
    Repo.all(Revenue)
  end

 # Listar as maiores receitas
 def list_largest_revenues(:desc) do
  from(r in Revenue,
    order_by: [desc: r.value],
    limit: 10
  )
  |> Repo.all()
end

# Listar as menores receitas
def list_smallest_revenues(:asc) do
  from(r in Revenue,
    order_by: [asc: r.value],
    limit: 10
  )
  |> Repo.all()
end

def list_monthly_revenues do
  from(r in Revenue,
    select: %{
      month: fragment("extract(month from ?)", r.date),
      total: sum(r.value)
    },
    group_by: fragment("extract(month from ?)", r.date),
    order_by: fragment("extract(month from ?)", r.date)
  )
  |> Repo.all()
end

def list_revenues_by_month(month) do
  month = if is_binary(month), do: String.to_integer(month), else: month

  from(r in Revenue,
    where: fragment("EXTRACT(MONTH FROM ?)", r.date) == ^month
  )
  |> Repo.all()
end

# Função para listar receitas por período
def list_revenues_by_period(start_date, end_date) do
  from(r in Revenue,
    where: r.date >= ^start_date and r.date <= ^end_date
  )
  |> Repo.all()
end

  # Função para cadastrar uma receita
  def create_revenue(attrs \\ %{}) do
    %Revenue{}
    |> Revenue.changeset(attrs)
    |> Repo.insert()
  end

  # Função para pegar uma receita por ID
  def get_revenue!(id), do: Repo.get!(Revenue, id)

  # Função para atualizar uma receita
  def update_revenue(%Revenue{} = revenue, attrs) do
    revenue
    |> Revenue.changeset(attrs)
    |> Repo.update()
  end

  # Função para deletar uma receita
  def delete_revenue(%Revenue{} = revenue) do
    Repo.delete(revenue)
  end

  # Função para mudar os dados de uma receita
  def change_revenue(%Revenue{} = revenue) do
    Revenue.changeset(revenue, %{})
  end

  def list_expenses do
    Repo.all(Expense)
  end

  def list_expenses_by_month(month) do
    month = if is_binary(month), do: String.to_integer(month), else: month

    from(e in Expense,
      where: fragment("EXTRACT(MONTH FROM ?)", e.date) == ^month
    )
    |> Repo.all()
  end

  # Função para listar despesas por período
  def list_expenses_by_period(start_date, end_date) do
    from(e in Expense,
      where: e.date >= ^start_date and e.date <= ^end_date
    )
    |> Repo.all()
  end

  # Listar as maiores receitas
  def list_largest_expenses(:desc) do
    from(e in Expense,
      order_by: [desc: e.value],
      limit: 10
    )
    |> Repo.all()
  end

  # Listar as menores receitas
  def list_smallest_expenses(:asc) do
    from(e in Expense,
      order_by: [asc: e.value],
      limit: 10
    )
    |> Repo.all()
  end

  # Função para cadastrar uma despesa
  def create_expense(attrs \\ %{}) do
    %Expense{}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  # Função para pegar uma despesa por ID
  def get_expense!(id), do: Repo.get!(Expense, id)

  # Função para atualizar uma despesa
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  # Função para deletar uma despesa
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  # Função para mudar os dados de uma despesa
  def change_expense(%Expense{} = expense) do
    Expense.changeset(expense, %{})
  end
end
