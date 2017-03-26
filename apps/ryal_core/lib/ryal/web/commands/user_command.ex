defmodule Ryal.UserCommand do
  alias Ryal.PaymentGatewayCommand

  def create(changeset) do
    with {:ok, changeset} <- Ryal.repo.insert(changeset),
         {:ok, _payment_gateway} <- PaymentGatewayCommand.create(changeset),
      do: {:ok, changeset}
  end
end
