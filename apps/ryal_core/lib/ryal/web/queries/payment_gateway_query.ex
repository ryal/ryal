defmodule Ryal.PaymentGatewayQuery do
  @moduledoc "Query's for the `Ryal.PaymentGateway`."

  import Ecto.Query, only: [from: 2]

  alias Ryal.PaymentGateway

  @doc "Searches for a `Ryal.PaymentGateway` via its `user_id`."
  @spec by_user_id(integer) :: Ecto.Query.t
  def by_user_id(user_id) do
    from pg in PaymentGateway,
      where: pg.user_id == ^user_id
  end
end
