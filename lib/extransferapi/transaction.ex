defmodule Extransferapi.Transaction do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Ecto.{Multi, Changeset}
  alias Extransferapi.{Repo, Auth}
  alias Extransferapi.Auth.{Account, AccountToken}
  alias Extransferapi.Transaction.Transfer

  def validate_account_balance(account, value) do
    case account do
      account when account.balance >= value ->
        {:ok, account}
      _ ->
        {:error, "You don't have balance"}
    end
  end

  def register_transaction(token, value, receiver_cpf) do
    with %Account{} = sender_account <- Auth.get_account_by_session_token(token),
         %Account{} = receiver_account <- Auth.get_account_by_cpf(receiver_cpf),
         {:ok, _} <- validate_account_balance(sender_account, value) do

          Multi.new()
          |> Multi.insert(:transfer, transfer = %Transfer{sender_id: sender_account.id, receiver_id: receiver_account.id, value: value})
          |> Multi.update(:sender_account, Changeset.change(sender_account, balance: sender_account.balance - value))
          |> Multi.update(:receiver_account, Changeset.change(receiver_account, balance: receiver_account.balance + value))
          |> Repo.transaction
          transfer
    else
      _ -> :error
    end
  end
end
