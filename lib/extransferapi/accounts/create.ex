defmodule Extransferapi.Accounts.Create do

  alias Extransferapi.{Repo, Account}

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
