defmodule Ryal.UserCommand do
  @moduledoc """
  CRUD commands for users. We use this to be able to help manage the external
  state of users on payment gateway platforms.
  """

  alias Ryal.PaymentGatewayCommand

  @doc """
  Creates a new user and iterates over all of the enabled payment gateways to
  setup a profile for them.
  """
  @spec create(Ecto.Changeset.t) :: {:ok, Ecto.Schema.t}
  def create(changeset) do
    with {:ok, user} <- Ryal.repo.insert(changeset),
         {:ok, _default_payment_gateway} <- PaymentGatewayCommand.create(user),
      do: {:ok, user}
  end

  @doc """
  When you change the information of a user, we also tell the payment gateway
  that it needs to update its information of your user. Doing so is run async.
  """
  @spec update(Ecto.Changeset.t) :: {:ok, Ecto.Schema.t}
  def update(changeset) do
    with {:ok, user} <- Ryal.repo.update(changeset),
         [_] <- PaymentGatewayCommand.update(user),
      do: {:ok, user}
  end

  @doc """
  When a user is deleted, we first delete its records from the payment gateways
  (async) and then finally delete the user from the DB.
  """
  @spec delete(Ecto.Schema.t) :: {:ok, Ecto.Schema.t}
  def delete(user) do
    with [_] <- PaymentGatewayCommand.delete(user),
      do: Ryal.repo.delete(user)
  end
end
