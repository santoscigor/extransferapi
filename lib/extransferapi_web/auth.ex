defmodule ExtransferapiWeb.Auth do
  import Plug.Conn

  alias Extransferapi.Auth

  def get_token(account) do
    Auth.generate_account_session_token(account)
  end

  def delete_token(token) do
    Auth.delete_session_token(token)
  end

  def fetch_current_account(conn) do
    token = fetch_token(get_req_header(conn, "authorization"))
    if !is_nil(token) do
      Auth.get_account_by_session_token(token)
    end
  end

  def fetch_current_account(conn, _opts) do
    token = fetch_token(get_req_header(conn, "authorization"))
    account = token && Auth.get_account_by_session_token(token)
    assign(conn, :current_account, account)
  end

  def require_guest_account(conn, _opts) do
    if conn.assigns[:current_account] do
      conn
      |> put_status(401)
      |> Phoenix.Controller.put_view(Extransferapi.ErrorView)
      |> Phoenix.Controller.render(:"401")
      |> halt()
    else
      conn
    end
  end

  def require_authenticated_account(conn, _opts) do
    if conn.assigns[:current_account] != nil and conn.assigns[:current_account].is_active do
      conn
    else
      conn
      |> put_status(401)
      |> Phoenix.Controller.put_view(Extransferapi.ErrorView)
      |> Phoenix.Controller.render(:"401")
      |> halt()
    end
  end

  # Taken from https://github.com/bobbypriambodo/phoenix_token_plug/blob/master/lib/phoenix_token_plug/verify_header.ex
  defp fetch_token([]), do: nil

  defp fetch_token([token | _tail]) do
    token
    |> String.replace("Token ", "")
    |> String.trim()
  end
end
