defmodule Dummy.User do
  use Dummy.Web, :model

  schema "users" do
    field :email, :string

    has_many :payment_methods, Ryal.PaymentMethod
    has_many :user_gateways, Ryal.UserGateway
    has_many :orders, Ryal.Order

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
