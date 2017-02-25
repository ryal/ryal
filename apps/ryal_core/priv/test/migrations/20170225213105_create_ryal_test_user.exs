defmodule Ryal.Repo.Migrations.CreateTestUser do
  use Ecto.Migration

  def change do
    create table(:ryal_test_user) do
      add :email, :string, null: false

      timestamps()
    end

    create unique_index :ryal_test_user, :email
  end
end
