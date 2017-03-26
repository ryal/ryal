defmodule Ryal.PaymentMethod do
  @moduledoc """
  A standard adapter to multiple payment methods.

  TODO: Payment Method documentation as this model becomes more fledged out.
  """

  use Ryal.Web, :model

  schema "ryal_payment_methods" do
    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()
  end
end
