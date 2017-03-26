defmodule Ryal.PaymentGatewayCommand do
  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Stripe.Customer

  def create(user) do
    struct = %PaymentGateway{type: "stripe", user_id: user.id}

    with {:ok, external_id} <- Customer.create(user),
         changeset <-
           PaymentGateway.changeset(%{struct | external_id: external_id}),
      do: Ryal.repo.insert(changeset)
  end
end
