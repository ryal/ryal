defmodule Ryal.UserGateway do
  @moduledoc """
  For each gateway that an application is using, we have a profile or record of
  the `User`'s existence on that gateway. Think of it as a join table between a
  `User` and a payment provider.
  """

  use Ryal.Web, :model

  schema "ryal_user_gateways" do
    field :type, :string

    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()
  end
end
