defmodule Extransferapi.Repo.Migrations.CreateTransfersTable do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :reversal_transfer_id, :uuid, null: true
      add :sender_id, :uuid, null: false
      add :receiver_id, :uuid, null: false
      add :value, :decimal,  precision: 11, scale: 2

      timestamps()
    end

    create unique_index(:transfers, [:reversal_transfer_id])
  end
end
