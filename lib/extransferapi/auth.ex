defmodule Extransferapi.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Extransferapi.Repo
  alias Extransferapi.Auth.{Account, AccountToken}

  def get_account_by_cpf(cpf) when is_binary(cpf) do
    Repo.get_by(Account, cpf: cpf)
  end

  def get_account_by_cpf_and_password(cpf, password)
      when is_binary(cpf) and is_binary(password) do
    account = Repo.get_by(Account, cpf: cpf)
    if Account.valid_password?(account, password), do: account
  end

  def get_account!(id), do: Repo.get!(Account, id)

  def register_account(attrs) do
    %Account{}
    |> Account.registration_changeset(attrs)
    |> Repo.insert()
  end

  def register_account!(attrs) do
    %Account{}
    |> Account.registration_changeset(attrs)
    |> Repo.insert!()
  end

 def change_account_registration(%Account{} = account, attrs \\ %{}) do
    Account.registration_changeset(account, attrs, hash_password: false)
  end

  def generate_account_session_token(account) do
    {token, account_token} = AccountToken.build_session_token(account)
    Repo.insert!(account_token)
    token
  end

  def get_account_by_session_token(token) do
    {:ok, query} = AccountToken.verify_session_token_query(token)
    Repo.one(query)
  end

  def delete_session_token(token) do
    Repo.delete_all(AccountToken.token_and_context_query(token, "session"))
    :ok
  end
end
