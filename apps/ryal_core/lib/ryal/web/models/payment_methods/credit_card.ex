defmodule Ryal.PaymentMethod.CreditCard do
  @moduledoc """
  Welcome to `Ryal.PaymentMethod.CreditCard`! Here, we store credit cards! OK,
  not actually...

  Well, we actually just store the information that would be of use for a user
  and then the actual sensitive data with your payment gateways; the guys with
  all that bank level security.

  The `month` and `year` are both two digit fields that should come in as
  strings. CVC is whichever you like it; it's a virtual string field. Finally,
  that `number` field? It's a string as well. And don't worry about spaces,
  tabs, or even line endings, we handle that :)
  """

  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3, validate_required: 2, put_change: 3]

  embedded_schema do
    field :name, :string

    field :last_digits, :string
    field :number, :string, virtual: true

    field :month, :string
    field :year, :string

    field :cvc, :string, virtual: true
  end

  @required_fields ~w(name number month year cvc)a

  @doc """
  Does the usual of what changesets usually do. Except, here we have some magic!
  We're going to just take the virtual field, number, clean it up, and then
  store the last four digits.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> cast_number_to_last_digits
    |> validate_required([:last_digits])
  end

  defp cast_number_to_last_digits(changeset) do
    number = Regex.replace(~r/[[:space:]]/, changeset.changes.number, "")
    {_, digits} = String.split_at(number, -4)

    changeset
    |> put_change(:number, number)
    |> put_change(:last_digits, digits)
  end
end
