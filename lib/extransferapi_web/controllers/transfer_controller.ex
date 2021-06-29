defmodule ExtransferapiWeb.TransferController do
  use ExtransferapiWeb, :controller

  alias ExtransferapiWeb.Auth
  alias Extransferapi.Transaction
  import ExtransferapiWeb.Auth

  action_fallback ExtransferapiWeb.FallbackController

  plug :require_authenticated_account when action in [:transfer, :revert_transfer, :get_by_date]

  def transfer(conn, %{"receiver_cpf" => receiver_cpf, "value" => value}) do
    token = conn
    |> Auth.fetch_current_account()
    |> get_token()

    transfer = Transaction.register_transaction(token, value, receiver_cpf)

    case transfer do
      {:error, message} -> {:error, :bad_request, message}
      _ ->  render(conn, "register.json", transfer: transfer)
    end
  end

  def revert_transfer(conn, %{"transfer_id" => transfer_id}) do
    account = Auth.fetch_current_account(conn)
    transfer = Transaction.reverse_transaction(transfer_id, account.id)
    render(conn, "register.json", transfer: transfer)
  end

  def get_by_date(conn, %{"start_date" => start_date, "end_date" => end_date}) do
    account = Auth.fetch_current_account(conn)
    transfer = Transaction.get_transactions_by_date(start_date, end_date, account.id)
    render(conn, "transaction_list.json", transfer: transfer)
  end
end
