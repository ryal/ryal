defmodule Ryal.UserCommandTest do
  use Ryal.ModelCase

  alias Dummy.User

  alias Ryal.PaymentGateway
  alias Ryal.UserCommand

  describe ".create/1" do
    test "will create a user with payment gateway" do
      changeset = Ryal.user_module.changeset(%User{email: "test@ryal.com"})

      assert [] == Ryal.repo.all(User)
      assert [] == Ryal.repo.all(PaymentGateway)

      assert {:ok, _user} = UserCommand.create(changeset)

      assert Ryal.repo.one!(User)
      assert Ryal.repo.one!(PaymentGateway)
    end
  end
end
