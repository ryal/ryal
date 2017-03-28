defmodule Ryal.PaymentGateway.CustomerTest do
  use Ryal.ModelCase

  import Mock

  alias Dummy.User
  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Customer

  setup do
    customer_data = "test/fixtures/stripe/customer.json"
      |> File.read!
      |> Poison.Parser.parse!(keys: :atoms)

    [customer_data: customer_data]
  end

  describe ".create/2" do
    test "bogus will return an id" do
      {:ok, id} = Customer.create(:bogus, %User{})
      assert String.length(id) == 10
    end

    test "stripe will return an id", %{customer_data: customer_data} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      create_response = fn(_params) -> {:ok, customer_data} end
      with_mock Stripe.Customers, [create: create_response] do
        assert {:ok, "cus_AMUcqwTDYlbBSp"} == Customer.create(:stripe, user)
      end
    end
  end

  describe ".update/2" do
    test "bogus can update" do
      assert {:ok, %{}} == Customer.update(:bogus, %{})
    end

    test "stripe will update their customer", %{customer_data: customer_data} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      gateway = %PaymentGateway{}
        |> PaymentGateway.changeset(%{type: "stripe", external_id: "cus_123", user_id: user.id})
        |> Repo.insert!
        |> Ryal.repo.preload(:user)

      update_response = fn("cus_123", _params) -> {:ok, customer_data} end
      with_mock Stripe.Customers, [update: update_response] do
        assert {:ok, _response} = Customer.update(:stripe, gateway)
      end
    end
  end

  describe ".delete/2" do
    test "bogus can delete" do
      assert {:ok, %{}} == Customer.delete(:bogus, %{})
    end

    test "stripe can delete their customer", %{customer_data: customer_data} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      gateway = %PaymentGateway{}
        |> PaymentGateway.changeset(%{type: "stripe", external_id: "cus_123", user_id: user.id})
        |> Repo.insert!
        |> Ryal.repo.preload(:user)

      update_response = fn("cus_123") -> {:ok, customer_data} end
      with_mock Stripe.Customers, [delete: update_response] do
        assert {:ok, _response} = Customer.delete(:stripe, gateway)
      end
    end
  end
end
