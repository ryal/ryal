defmodule Ryal.PaymentMethod.CreditCardTest do
  use Ryal.ModelCase, async: true

  alias Ryal.PaymentMethod.CreditCard

  describe ".changeset/2" do
    setup do
      [
        attrs: %{
          name: "Bobby Orr",
          number: "4242 4242 4242 4242",
          month: "03",
          year: "2048",
          cvc: "004"
        }
      ]
    end

    test "won't break when there's no number" do
      refute CreditCard.changeset(%CreditCard{}, %{}).valid?
    end

    test "will create a new credit card changeset", %{attrs: params} do
      changeset = CreditCard.changeset(%CreditCard{}, params)

      assert changeset.changes.number == "4242424242424242"
      assert changeset.changes.last_digits == "4242"
      assert changeset.valid?
    end

    test "can use numbers with tabs", %{attrs: params} do
      params = %{params | number: "4242 4242  4242  4242"}
      changeset = CreditCard.changeset(%CreditCard{}, params)

      assert changeset.changes.number == "4242424242424242"
      assert changeset.changes.last_digits == "4242"
      assert changeset.valid?
    end

    test "can use numbers with line endings", %{attrs: params} do
      params = %{params | number: """
        4242
        4242
        4242
        4242
        """
      }
      changeset = CreditCard.changeset(%CreditCard{}, params)

      assert changeset.changes.number == "4242424242424242"
      assert changeset.changes.last_digits == "4242"
      assert changeset.valid?
    end
  end
end
