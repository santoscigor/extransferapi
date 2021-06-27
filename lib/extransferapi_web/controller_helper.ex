defmodule ExtransferapiWeb.ControllerHelper do
  def current_account(conn) do
    conn.assigns[:current_account]
  end
end
