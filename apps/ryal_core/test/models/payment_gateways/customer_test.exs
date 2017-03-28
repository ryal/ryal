defmodule Ryal.PaymentGateway.CustomerTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGateway.Customer

  describe ".create/1" do
    test "bogus will return an id" do
      {:ok, id} = Customer.create(:bogus, %User{})
      assert String.length(id) == 10
    end
  end
end
