defmodule Ryal.PaymentGatewayCommand do
  @moduledoc """
  CRUD commands for `Ryal.PaymentGateway`s. Often used to managed the
  `external_id`s from payment gateways.
  """

  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Customer

  @default_gateway Map.get(Ryal.payment_gateway, :default)
  @fallback_gateways Map.get(Ryal.payment_gateway, :fallbacks)

  def create(user) do
    Enum.each @fallback_gateways || [], fn(gateway_type) ->
      spawn_monitor fn -> create(gateway_type, user) end
    end

    create @default_gateway, user
  end

  @doc """
  Given a user and a gateway type, we'll create a new `Ryal.PaymentGateway` for
  that user.
  """
  @spec create(atom, Ecto.Schema.t) ::
    {:ok, Ecto.Schema.t} | {:error, Ecto.Changeset.t}
  def create(type, user) do
    struct = %PaymentGateway{type: Atom.to_string(type), user_id: user.id}

    with {:ok, external_id} <- Customer.create(type, user),
         changeset <-
           PaymentGateway.changeset(%{struct | external_id: external_id}),
      do: Ryal.repo.insert(changeset)
  end

  @doc """
  Give us a user id and we'll update the payment gateways with the user's
  information.
  """
  @spec update(Ecto.Schema.t) :: []
  def update(user), do: update_payment_gateways(user, :update)

  @doc """
  If you're going to be deleting your user, then we'll delete the user on the
  payment gateway as well.
  """
  @spec delete(Ecto.Schema.t) :: []
  def delete(user), do: update_payment_gateways(user, :delete)

  defp update_payment_gateways(user, action) do
    user = Ryal.repo.preload(user, :payment_gateways)

    Enum.map user.payment_gateways, fn(payment_gateway) ->
      type = String.to_atom payment_gateway.type
      spawn_monitor Customer, action, [type, payment_gateway]
    end
  end
end
