defmodule Ryal.Repo.Migrations.CreateRyalPaymentMethods do
  use Ecto.Migration

  def change do
    create table(:ryal_payment_methods) do
      add :type, :string, null: false
      add :proxy, :map, null: false

      add :user_id, references(Ryal.user_table()), null: false

      timestamps()
    end
  end
end
