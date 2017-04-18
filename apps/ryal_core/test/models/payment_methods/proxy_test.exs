defmodule Ryal.PaymentMethod.ProxyTest do
  use Ryal.ModelCase, async: true

  alias Ryal.PaymentMethod.Proxy
  alias Ryal.PaymentMethod.CreditCard

  import Ecto.Changeset, only: [cast: 3]

  describe ".changeset/2" do
    test "will work with empty maps" do
      expectation = cast(%Proxy{}, %{}, [])
      assert Proxy.changeset(%Proxy{}, %{}) == expectation
    end

    test "will select changeset based on struct provided" do
      params = Map.from_struct(%CreditCard{})
      changeset = CreditCard.changeset(%CreditCard{}, params)
      expectation = cast(%Proxy{}, %{data: params}, [:data])
      assert Proxy.changeset(%Proxy{}, %CreditCard{}) == Map.merge(expectation, %{
          errors: changeset.errors,
          valid?: false
        })
    end
  end
end
