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
  @spec create(Ecto.Changeset.t) :: {:ok, Ecto.Changeset.t}
  def create(changeset) do
    with {:ok, changeset} <- Ryal.repo.insert(changeset),
         {:ok, _payment_gateway} <- PaymentGatewayCommand.create(:stripe, changeset),
      do: {:ok, changeset}
  end
end
