defmodule FinancialManagerWeb.RevenueHTML do
  use FinancialManagerWeb, :html

  embed_templates "revenue_html/*"

  @doc """
  Renders a revenue form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def revenue_form(assigns)
end
