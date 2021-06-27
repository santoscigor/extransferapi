defmodule Extransferapi.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Extransferapi.Repo
  alias Extransferapi.Auth.{Account, AccountToken}

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

end
