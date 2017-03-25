defmodule Ryal.PaymentMethod do
  use Ryal.Web, :model

  schema "ryal_payment_methods" do
    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()
  end
end
