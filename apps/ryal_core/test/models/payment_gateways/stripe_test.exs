defmodule Ryal.PaymentGateway.StripeTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Stripe
  alias Ryal.PaymentMethod
  alias Plug.Conn

  setup do
    [bypass: Bypass.open]
  end

  describe ".create/3" do
    setup do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      [user: user]
    end

    test "will return an id for a customer", %{bypass: bypass, user: user} do
      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers" == conn.request_path
        assert "POST" == conn.method

        Conn.resp(conn, 201, read_fixture("stripe/customer.json"))
      end

      result = Stripe.create(:customer, user, bypass_endpoint(bypass))
      assert {:ok, "cus_AMUcqwTDYlbBSp"} == result
    end

    test "will return an id for a credit card", %{bypass: bypass, user: user} do
      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers/cus_123/sources" == conn.request_path
        assert "POST" == conn.method

        Conn.resp(conn, 201, read_fixture("stripe/credit_card.json"))
      end

      %PaymentGateway{}
      |> PaymentGateway.changeset(%{type: "stripe", external_id: "cus_123", user_id: user.id})
      |> Repo.insert!

      credit_card = %PaymentMethod{}
        |> PaymentMethod.changeset(%{
            type: "credit_card",
            user_id: user.id,
            proxy: %{
              name: "Bobby Orr",
              number: "4242 4242 4242 4242",
              month: "08",
              year: "2029",
              cvc: "123"
            }
          })
        |> Ryal.repo.insert!

      result = Stripe.create(:credit_card, credit_card, bypass_endpoint(bypass))
      assert {:ok, "card_1AA3En2BZSQJcNSQ77orWzVS"} == result
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
