defmodule Ryal.Repo.Migrations.CreateRyalOrders do
  use Ecto.Migration

  def change do
    create table(:ryal_orders) do
      add :number, :string, null: false
      add :state, :string, default: "cart", null: false
      add :total, :decimal, null: false

      timestamps()
    end

    create unique_index :ryal_orders, :number
  end
end
