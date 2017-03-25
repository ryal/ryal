defmodule Ryal.Repo.Migrations.CreateRyalUserGateways do
  use Ecto.Migration

  def change do
    create table(:ryal_user_gateways) do
      add :type, :string, null: false

      add :user_id, references(Ryal.user_table()), null: false

      timestamps()
    end
  end
end
