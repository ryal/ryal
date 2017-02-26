defmodule Ryal.OrderTest do
  use Ryal.ModelCase

  alias Ryal.Order

  describe "generate_number/1" do
    test "will create a random payment number" do
      changeset = Order.changeset(%Order{})
      "R" <> numbers = changeset.changes.number
      assert String.length(numbers) == 9
    end
  end
end
