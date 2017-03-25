defmodule Ryal.PaymentMethodGateway do
  use Ryal.Web, :model

  schema "ryal_payment_method_gateways" do
    has_many :payments, Ryal.Payment

    belongs_to :payment_method, Ryal.PaymentMethod
    belongs_to :user_gateway, Ryal.UserGateway
  end
end
