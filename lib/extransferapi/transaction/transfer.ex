defmodule Extransferapi.Transaction.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:reversal_transfer_id, :sender_id, :receiver_id, :value]
  @required [:sender_id, :receiver_id, :value]

  schema "transfers" do
    field :reversal_transfer_id, :binary_id, null: true
    field :sender_id, :binary_id, null: false
    field :receiver_id, :binary_id, null: false
    field :value, :integer

    timestamps()
  end

  def registration_changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@required)
    |> unique_constraint([:reversal_transfer_id])
  end
end
