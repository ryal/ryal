defmodule Dummy.User do
  @moduledoc false

  use Dummy.Web, :model

  schema "users" do
    field :email, :string

    has_many :orders, Ryal.Order
    has_many :payment_gateways, Ryal.PaymentGateway
    has_many :payment_methods, Ryal.PaymentMethod

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
