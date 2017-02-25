defmodule Ryal.PaymentTest do
  use Ryal.ModelCase

  alias Ryal.Payment

  describe "generate_number/1" do
    test "will create a random payment number" do
      changeset = Payment.changeset(%Payment{}, %{amount: 10.00})
      "P" <> numbers = changeset.changes.number
      assert String.length(numbers) == 9
    end
  end
end
