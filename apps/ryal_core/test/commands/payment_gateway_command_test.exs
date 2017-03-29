defmodule Ryal.PaymentGatewayCommandTest do
  use Ryal.ModelCase

  alias Dummy.User

  alias Ryal.PaymentGateway
  alias Ryal.PaymentGatewayCommand

  setup do
    user = %User{email: "hello@example.com"}
      |> User.changeset
      |> Repo.insert!

    [user: user]
  end

  describe ".create/1" do
    test "will create a new bogus customer", %{user: user} do
      assert [] == Ryal.repo.all(PaymentGateway)
      assert PaymentGatewayCommand.create(:bogus, user)
      assert Ryal.repo.one!(PaymentGateway)
    end
  end

  describe ".update/1" do
    test "will update all bogus customers", %{user: user} do
      {:ok, _} = PaymentGatewayCommand.create(:bogus, user)

      Enum.each PaymentGatewayCommand.update(user.id), fn({_status, ref}) ->
        assert_receive {:DOWN, ^ref, :process, _, :normal}, 500
      end
    end
  end

  describe ".delete/1" do
    test "will delete all bogus customers", %{user: user} do
      {:ok, _} = PaymentGatewayCommand.create(:bogus, user)

      Enum.each PaymentGatewayCommand.delete(user.id), fn({_status, ref}) ->
        assert_receive {:DOWN, ^ref, :process, _, :normal}, 500
      end
    end
  end
end
