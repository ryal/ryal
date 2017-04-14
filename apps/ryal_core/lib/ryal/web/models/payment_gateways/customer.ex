defmodule Ryal.PaymentGateway.Customer do
  @moduledoc "The Customer wrapper around multiple payment gateways."

  @stripe_api_key Map.get(Ryal.payment_gateway_keys, :stripe)
  @stripe_base "https://#{@stripe_api_key}:@api.stripe.com/v1"

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
    response = @stripe_base
      <> "/customers"
      |> HTTPotion.post([body: stripe_params(user)])

    with {:ok, body} <- Poison.decode(response.body),
      do: {:ok, body["id"]}
  end

  @spec update(atom, Ecto.Schema.t) :: {:ok, %{}}

  @doc "Simple bogus updating of user attributes."
  def update(:bogus, _payment_gateway), do: {:ok, %{}}

  @doc "Updates information on Stripe when the user data changes."
  def update(:stripe, payment_gateway) do
    user = payment_gateway.user

    response = @stripe_base
      <> "/customers/#{payment_gateway.external_id}"
      |> HTTPotion.post([body: stripe_params(user)])

    Poison.decode(response.body)
  end

  @spec delete(atom, Ecto.Schema.t) :: {:ok, %{}}

  @doc "Simple customer deletion on a bogus gateway."
  def delete(:bogus, _payment_gateway), do: {:ok, %{}}

  @doc "Marks a customer account on Stripe as deleted."
  def delete(:stripe, payment_gateway) do
    response = @stripe_base
      <> "/customers/#{payment_gateway.external_id}"
      |> HTTPotion.delete

    Poison.decode(response.body)
  end

  defp stripe_params(user) do
    URI.encode_query %{
      email: user.email,
      description: "Customer #{user.id} from Ryal."
    }
  end
end
