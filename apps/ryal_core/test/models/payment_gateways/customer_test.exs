defmodule Ryal.PaymentGateway.CustomerTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGateway
  alias Ryal.PaymentGateway.Customer
  alias Plug.Conn

  setup do
    [bypass: Bypass.open]
  end

  describe ".create/3" do
    test "bogus will return an id" do
      {:ok, id} = Customer.create(:bogus, %User{})
      assert String.length(id) == 10
    end

    test "stripe will return an id", %{bypass: bypass} do
      Bypass.expect bypass, fn(conn) ->
        assert "/v1/customers" == conn.request_path
        assert "POST" == conn.method

        Conn.resp(conn, 201, read_fixture("stripe/customer.json"))
      end

      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      result = Customer.create(:stripe, user, bypass_endpoint(bypass))
      assert {:ok, "cus_AMUcqwTDYlbBSp"} == result
    end
  end

  describe ".update/3" do
    test "bogus can update" do
      assert {:ok, %{}} == Customer.update(:bogus, %{})
    end

    test "stripe will update their customer", %{bypass: bypass} do
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

      result = Customer.update(:stripe, gateway, bypass_endpoint(bypass))
      assert {:ok, _response} = result
    end
  end

  describe ".delete/3" do
    test "bogus can delete" do
      assert {:ok, %{}} == Customer.delete(:bogus, %{})
    end

    test "stripe can delete their customer", %{bypass: bypass} do
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

      result = Customer.delete(:stripe, gateway, bypass_endpoint(bypass))
      assert {:ok, _response} = result
    end
  end

  defp bypass_endpoint(bypass), do: "http://localhost:#{bypass.port}"
  defp read_fixture(fixture), do: File.read!("test/fixtures/#{fixture}")
end
