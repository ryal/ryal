defmodule Ryal.PaymentGateway.BogusTest do
  use Ryal.ModelCase

  alias Dummy.User
  alias Ryal.PaymentGateway.Bogus

  describe ".create/2" do
    test "bogus will return an id" do
      {:ok, id} = Bogus.create(:customer, %User{})
      assert String.length(id) == 10
    end
  end

  describe ".update/2" do
    test "bogus can update" do
      assert {:ok, %{}} == Bogus.update(:bogus, %User{})
    end
  end

  describe ".delete/2" do
    test "bogus can delete" do
      assert {:ok, %{}} == Bogus.delete(:bogus, %User{})
    end
  end
end
