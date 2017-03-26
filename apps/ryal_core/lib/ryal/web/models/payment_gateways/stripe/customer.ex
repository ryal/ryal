defmodule Ryal.PaymentGateway.Stripe.Customer do
  @moduledoc """
  The Customer wrapper around the Stripe gateway.
  """

  alias Stripe.Customers

  @spec create(Ecto.Changeset.t) :: String.t
  def create(changeset) do
    params = %{
      email: changeset.email,
      description: "Customer #{changeset.id} from Ryal."
    }

    with {:ok, response} <- Customers.create(params),
         do: {:ok, response.id}
  end
end
