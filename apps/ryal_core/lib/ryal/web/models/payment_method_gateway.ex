defmodule Ryal.PaymentMethodGateway do
  @moduledoc """
  A join table between a `Ryal.PaymentGateway` and a `Ryal.PaymentMethod`, this
  model is responsible for connecting a payment to a user's payment method and
  billing it under the appropriate `Ryal.PaymentGateway`.
  """

  use Ryal.Web, :model

  schema "ryal_payment_method_gateways" do
    has_many :payments, Ryal.Payment

    belongs_to :payment_gateway, Ryal.PaymentGateway
    belongs_to :payment_method, Ryal.PaymentMethod
  end
end
