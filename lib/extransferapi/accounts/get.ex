defmodule Extransferapi.Accounts.Get do
  alias Ecto.UUID
  alias Extransferapi.{Repo, Account}

  def call(params) do
    params
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(Account, uuid) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

end
