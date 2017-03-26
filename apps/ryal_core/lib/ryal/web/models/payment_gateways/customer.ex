defmodule Ryal.PaymentGateway.Customer do
  @moduledoc "The Customer wrapper around multiple payment gateways."

  alias Stripe.Customers

  @spec create(atom, Ecto.Schema.t) :: String.t

  @doc """
  Creates a new customer on Stripe with an email and a simple description.
  """
  def create(:stripe, user) do
    params = %{
      email: user.email,
      description: "Customer #{user.id} from Ryal."
    }

    with {:ok, response} <- Customers.create(params),
      do: {:ok, response.id}
  end
end
