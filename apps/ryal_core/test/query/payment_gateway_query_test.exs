defmodule Ryal.PaymentGatewayQueryTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGatewayQuery
  alias Ryal.UserCommand

  describe ".by_user_id/1" do
    test "will collect the appropriate users" do
      {:ok, user1} = %User{}
        |> User.changeset(%{email: "hello@example.com"})
        |> UserCommand.create

      user1 = Ryal.repo.preload(user1, :payment_gateways)

      {:ok, _user2} = %User{}
        |> User.changeset(%{email: "hi@example.com"})
        |> UserCommand.create

      users = user1.id
        |> PaymentGatewayQuery.by_user_id
        |> Ryal.repo.all

      assert user1.payment_gateways == users
    end
  end
end
