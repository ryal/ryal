defmodule Ryal.PaymentMethodGateway do
  @moduledoc """
  A join table between a `PaymentGateway` and a `PaymentMethod`, this model is
  responsible for connecting a payment to a user's payment method and billing it
  under the appropriate `PaymentGateway`.
  """

  use Ryal.Web, :model

  schema "ryal_payment_method_gateways" do
    has_many :payments, Ryal.Payment

    belongs_to :payment_method, Ryal.PaymentMethod
    belongs_to :user_gateway, Ryal.UserGateway
  end
end
