defmodule Ryal.UserGateway do
  use Ryal.Web, :model

  schema "ryal_user_gateways" do
    field :type, :string

    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()
  end
end
