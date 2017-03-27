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

  @doc "Simple bogus creation for an external_id."
  def create(:bogus, _user) do
    rand_id = :rand.uniform * 10_000_000_000
      |> round
      |> to_string

    {:ok, rand_id}
  end
end
