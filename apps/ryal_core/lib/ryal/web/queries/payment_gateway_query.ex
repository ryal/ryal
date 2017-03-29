defmodule Ryal.PaymentGatewayQuery do
  import Ecto.Query, only: [from: 2]

  alias Ryal.PaymentGateway

  def by_user_id(user_id) do
    from pg in PaymentGateway,
      where: pg.user_id == ^user_id
  end
end
