defmodule Ryal.Repo.Migrations.CreateRyalPaymentMethodGateways do
  use Ecto.Migration

  def change do
    create table(:ryal_payment_method_gateways) do
      add :payment_method_id, references(:ryal_payment_methods), null: false
      add :user_gateway_id, references(:ryal_user_gateways), null: false

      timestamps()
    end
  end
end
