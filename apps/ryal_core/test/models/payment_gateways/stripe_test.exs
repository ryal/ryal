defmodule Ryal.PaymentGateway.StripeTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Stripe
  alias Ryal.PaymentMethod.CreditCard
  alias Plug.Conn

  setup do
    [bypass: Bypass.open]
  end

  describe ".create/3" do
    test "will return an id for a customer", %{bypass: bypass} do
      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers" == conn.request_path
        assert "POST" == conn.method

        Conn.resp(conn, 201, read_fixture("stripe/customer.json"))
      end

      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      result = Stripe.create(:customer, user, bypass_endpoint(bypass))
      assert {:ok, "cus_AMUcqwTDYlbBSp"} == result
    end

    test "will return an id for a credit card" do
      user = %CreditCard{}
    end
  end

  describe ".update/3" do
    test "can update a customer", %{bypass: bypass} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      gateway = %PaymentGateway{}
        |> PaymentGateway.changeset(%{type: "stripe", external_id: "cus_123", user_id: user.id})
        |> Repo.insert!
        |> Ryal.repo.preload(:user)

      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers/cus_123" == conn.request_path
        assert "POST" == conn.method

        Conn.resp(conn, 201, read_fixture("stripe/customer.json"))
      end

      result = Stripe.update(:customer, gateway, bypass_endpoint(bypass))
      assert {:ok, _response} = result
    end
  end

  describe ".delete/3" do
    test "can delete a customer", %{bypass: bypass} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      gateway = %PaymentGateway{}
        |> PaymentGateway.changeset(%{type: "stripe", external_id: "cus_123", user_id: user.id})
        |> Repo.insert!
        |> Ryal.repo.preload(:user)

      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers/cus_123" == conn.request_path
        assert "DELETE" == conn.method

        Conn.resp(conn, 200, read_fixture("stripe/customer.json"))
      end

      result = Stripe.delete(:customer, gateway, bypass_endpoint(bypass))
      assert {:ok, _response} = result
    end
  end

  defp bypass_endpoint(bypass), do: "http://localhost:#{bypass.port}"
  defp read_fixture(fixture), do: File.read!("test/fixtures/#{fixture}")
end
