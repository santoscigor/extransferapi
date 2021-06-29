defmodule ExtransferapiWeb.AccountController do
  use ExtransferapiWeb, :controller

  alias ExtransferapiWeb.Auth
  import ExtransferapiWeb.Auth

  action_fallback ExtransferapiWeb.FallbackController

  plug :require_authenticated_account when action in [:get_balance]

  def get_balance(conn, _) do
    render(conn, "get_balance.json", account: Auth.fetch_current_account(conn))
  end
end
