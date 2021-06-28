defmodule Extransferapi.Repo.Migrations.CreateTransfersTable do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :reversal_transfer_id, :binary_id, null: true
      add :sender_id, :binary_id, null: false
      add :receiver_id, :binary_id, null: false
      add :value, :integer

      timestamps()
    end

    create unique_index(:transfers, [:reversal_transfer_id])
  end
end
