defmodule Ryal.PaymentGatewayCommand do
  @moduledoc """
  CRUD commands for `Ryal.PaymentGateway`s. Often used to managed the
  `external_id`s from payment gateways.
  """

  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Customer

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
end
