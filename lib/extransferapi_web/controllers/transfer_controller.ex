defmodule ExtransferapiWeb.TransferController do
  use ExtransferapiWeb, :controller

  alias ExtransferapiWeb.Auth
  alias Extransferapi.Transaction
  import ExtransferapiWeb.Auth

  action_fallback ExtransferapiWeb.FallbackController

  plug :require_guest_account when action in [:login, :register]

  def transfer(conn, %{"receiver_cpf" => receiver_cpf, "value" => value}) do
    if account = Auth.fetch_current_account(conn) do
      token = get_token(account)
      transfer = Transaction.register_transaction(token, value, receiver_cpf)
      render(conn, "register.json", transfer: transfer)
    else
      {:error, :unauthorized}
    end
  end

  def revert_transfer(conn, %{"transfer_id" => transfer_id}) do
    transfer = Transaction.reverse_transaction(transfer_id)
    render(conn, "register.json", transfer: transfer)
  end

  def get_by_date(conn, %{"start_date" => start_date, "end_date" => end_date}) do
    transfer = Transaction.get_transactions_by_date(start_date, end_date)
    render(conn, "transaction_list.json", transfer: transfer)
  end
end
