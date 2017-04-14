defmodule Ryal.PaymentMethod.ProxyTest do
  use Ryal.ModelCase, async: true

  alias Ryal.PaymentMethod.Proxy
  alias Ryal.PaymentMethod.CreditCard

  describe ".changeset/2" do
    test "will work with empty maps" do
      expectation = Ecto.Changeset.cast(%Proxy{}, %{}, [])
      assert Proxy.changeset(%Proxy{}, %{}) == expectation
    end

    test "will select changeset based on struct provided" do
      params = Map.from_struct(%CreditCard{})
      expectation = CreditCard.changeset(%CreditCard{}, params)
      assert Proxy.changeset(%Proxy{}, %CreditCard{}) == expectation
    end
  end
end
