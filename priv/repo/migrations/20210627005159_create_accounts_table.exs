defmodule Extransferapi.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :firstname, :string
      add :lastname, :string
      add :cpf, :string
      add :password, :string
      add :balance, :decimal,  precision: 11, scale: 2

      timestamps()
    end

    create unique_index(:accounts, [:cpf])
  end
end
