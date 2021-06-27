defmodule Extransferapi.Account do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :firstname, :string
    field :lastname, :string
    field :cpf, :string,  precision: 11, scale: 0
    field :hashed_password, :string
    field :balance, :decimal,  precision: 11, scale: 2

    timestamps()
  end
end
