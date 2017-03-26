defmodule Ryal.Repo.Migrations.CreateRyalPaymentTransitions do
  use Ecto.Migration

  def change do
    create table(:ryal_payment_transitions) do
      add :from, :string, null: false
      add :to, :string, null: false
      add :event, :string, null: false
      add :result, :string, null: false

      add :payment_id, references(:ryal_payments), null: false

      timestamps()
    end
  end
end
