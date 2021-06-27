defmodule Extransferapi.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:firstname, :lastname, :cpf, :password, :balance]

  schema "accounts" do
    field :firstname, :string
    field :lastname, :string
    field :cpf, :string,  precision: 11, scale: 0
    field :password, :string
    field :balance, :decimal,  precision: 11, scale: 2

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:firstname, min: 2)
    |> validate_length(:lastname, min: 2)
    |> validate_length(:cpf, min: 11, max: 11)
    |> unique_constraint([:cpf])
  end
end
