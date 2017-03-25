defmodule Ryal.Repo.Migrations.CreateRyalPaymentMethods do
  use Ecto.Migration

  def change do
    create table(:ryal_payment_methods) do
      add :user_id, references(Ryal.user_table()), null: false

      timestamps()
    end
  end
end
