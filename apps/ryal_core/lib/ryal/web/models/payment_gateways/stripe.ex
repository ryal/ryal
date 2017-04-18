defmodule Ryal.PaymentGateway.Stripe do
  @moduledoc "Relevant functions for working with the Stipe API."

  alias Ryal.PaymentGatewayQuery

  @stripe_api_key Map.get(Ryal.payment_gateways(), :stripe)
  @stripe_base "https://#{@stripe_api_key}:@api.stripe.com"

  @spec create(atom, Ecto.Schema.t, String.t) :: {:ok, String.t}
  def create(type, schema, stripe_base \\ @stripe_base)

  def create(:credit_card, payment_method, stripe_base) do
    credit_card_data = payment_method.proxy.data
    customer_id = payment_method.user_id
      |> PaymentGatewayQuery.get_external_id("stripe")
      |> Ryal.repo.one!

    credit_card_path = "/v1/customers/#{customer_id}/sources"
    create_object credit_card_data, :credit_card, credit_card_path, stripe_base
  end

  def create(:customer, user, stripe_base) do
    create_object user, :customer, "/v1/customers", stripe_base
  end

  defp create_object(schema, type, path, stripe_base) do
    response = HTTPotion.post(stripe_base <> path, [body: params(type, schema)])

    with {:ok, body} <- Poison.decode(response.body),
      do: {:ok, body["id"]}
  end

  @spec update(atom, Ecto.Schema.t, String.t) :: {:ok, %{}}
  def update(type, schema, stripe_base \\ @stripe_base)

  @doc "Updates information on Stripe when the user data changes."
  def update(:customer, payment_gateway, stripe_base)  do
    user = payment_gateway.user

    response = stripe_base
      <> "/v1/customers/#{payment_gateway.external_id}"
      |> HTTPotion.post([body: params(:customer, user)])

    Poison.decode(response.body)
  end

  @spec delete(atom, Ecto.Schema.t, String.t) :: {:ok, %{}}
  def delete(atom, schema, stripe_base \\ @stripe_base)

  @doc "Marks a customer account on Stripe as deleted."
  def delete(:customer, payment_gateway, stripe_base) do
    response = stripe_base
      <> "/v1/customers/#{payment_gateway.external_id}"
      |> HTTPotion.delete

    Poison.decode(response.body)
  end

  defp params(:credit_card, credit_card) do
    URI.encode_query %{
      "source[object]" => "card",
      "source[exp_month]" => credit_card.month,
      "source[exp_year]" => credit_card.year,
      "source[number]" => credit_card.number,
      "source[cvc]" => credit_card.cvc,
      "source[name]" => credit_card.name
    }
  end

  defp params(:customer, user) do
    URI.encode_query %{
      email: user.email,
      description: "Customer #{user.id} from Ryal."
    }
  end
end
