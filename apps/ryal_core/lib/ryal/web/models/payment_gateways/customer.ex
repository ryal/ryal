defmodule Ryal.PaymentGateway.Customer do
  @moduledoc "The Customer wrapper around multiple payment gateways."

  alias Stripe.Customers

  @spec create(atom, Ecto.Schema.t) :: {:ok, String.t}

  @doc "Simple bogus creation for an external_id."
  def create(:bogus, _user) do
    rand_id = :rand.uniform * 10_000_000_000
      |> round
      |> to_string
      |> String.ljust(10, ?0)

    {:ok, rand_id}
  end

  @doc """
  Creates a new customer on Stripe with an email and a simple description.
  """
  def create(:stripe, user) do
    with {:ok, response} <- Customers.create(stripe_params user),
      do: {:ok, response.id}
  end

  @spec update(atom, Ecto.Schema.t) :: {:ok, %{}}

  @doc "Simple bogus updating of user attributes."
  def update(:bogus, _payment_gateway), do: {:ok, %{}}

  @doc "Updates information on Stripe when the user data changes."
  def update(:stripe, payment_gateway) do
    user = payment_gateway.user
    Customers.update(payment_gateway.external_id, stripe_params(user))
  end

  @spec delete(atom, Ecto.Schema.t) :: {:ok, %{}}

  @doc "Simple customer deletion on a bogus gateway."
  def delete(:bogus, _payment_gateway), do: {:ok, %{}}

  @doc "Marks a customer account on Stripe as deleted."
  def delete(:stripe, payment_gateway) do
    Customers.delete(payment_gateway.external_id)
  end

  defp stripe_params(user) do
    %{
      email: user.email,
      description: "Customer #{user.id} from Ryal."
    }
  end
end
