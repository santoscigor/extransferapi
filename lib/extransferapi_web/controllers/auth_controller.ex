defmodule ExtransferapiWeb.AuthController do
  use ExtransferapiWeb, :controller

  alias Extransferapi.Auth
  import ExtransferapiWeb.Auth

  action_fallback ExtransferapiWeb.FallbackController

  plug :require_guest_account when action in [:login, :register]

  def login(conn, %{"cpf" => cpf, "password" => password}) do
    if account = Auth.get_account_by_cpf_and_password(cpf, password) do
      token = get_token(account)
      render(conn, "login.json", account: account, token: token)
    else
      {:error, :bad_request, "Invalid cpf or password."}
    end
  end

  def register(conn, %{"account" => params}) do
    with {:ok, account} <- Auth.register_account(params) do

      conn
      |> put_status(201)
      |> render("register.json", account: account)
    end
  end
end
