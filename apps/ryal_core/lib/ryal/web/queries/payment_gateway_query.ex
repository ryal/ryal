defmodule Ryal.PaymentGatewayQuery do
  @moduledoc "Queries for the `Ryal.PaymentGateway`."

  use Ryal.Web, :query

  alias Ryal.PaymentGateway

  @doc """
  Have a user id and want to get its external_id to one of the payment
  gateways? This query should help you out fine.
  """
  @spec get_external_id(integer, String.t) :: Ecto.Query.t
  def get_external_id(user_id, gateway_type) do
    from pg in PaymentGateway,
      where: [user_id: ^user_id, type: ^gateway_type],
      select: pg.external_id
  end
end
