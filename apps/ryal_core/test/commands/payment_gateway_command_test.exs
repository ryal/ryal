defmodule Ryal.PaymentGatewayCommandTest do
  use Ryal.ModelCase

  alias Dummy.User

  alias Ryal.PaymentGateway
  alias Ryal.PaymentGatewayCommand

  describe ".create/1" do
    setup do
      user = %User{email: "hello@example.com"}
        |> User.changeset
        |> Repo.insert!

      [user: user]
    end

    test "will create a new stripe customer", %{user: user} do
      assert [] == Ryal.repo.all(PaymentGateway)
      assert {:ok, _payment_gateway} = PaymentGatewayCommand.create(:stripe, user)
      assert Ryal.repo.one!(PaymentGateway)
    end
  end
end
