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

    test "will create a new bogus customer", %{user: user} do
      assert [] == Ryal.repo.all(PaymentGateway)
      assert PaymentGatewayCommand.create(:bogus, user)
      assert Ryal.repo.one!(PaymentGateway)
    end
  end
end
