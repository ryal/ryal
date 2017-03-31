defmodule Ryal.UserCommandTest do
  use Ryal.ModelCase

  import Mock

  alias Dummy.User

  alias Ryal.PaymentGateway
  alias Ryal.PaymentGatewayCommand
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

  describe ".update/1" do
    setup do
      {:ok, user} = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> UserCommand.create

      [user: user]
    end

    test "will update a user", %{user: user} do
      {:ok, user} = user
        |> User.changeset(%{email: "ryal@updated.com"})
        |> UserCommand.update

      assert user.email == "ryal@updated.com"
    end

    test "will update payment gateway data", %{user: user} do
      with_mock PaymentGatewayCommand, [update: fn(_) -> [{:ok, ""}] end] do
        {:ok, user} = user
          |> User.changeset(%{email: "ryal@example.com"})
          |> UserCommand.update

        assert called PaymentGatewayCommand.update(user)
      end
    end
  end

  describe ".delete/1" do
    setup do
      {:ok, user} = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> UserCommand.create

      [user: user]
    end

    test "will delete the user from a payment gateway", %{user: user} do
      {:ok, _} = UserCommand.delete(user)

      assert_raise Ecto.NoResultsError, fn ->
        Ryal.repo.get!(Ryal.user_module, user.id)
      end
    end

    test "will delete the user", %{user: user} do
      with_mock PaymentGatewayCommand, [delete: &([ok: &1])] do
        {:ok, _} = UserCommand.delete(user)

        assert called PaymentGatewayCommand.delete(user)
      end
    end
  end
end
