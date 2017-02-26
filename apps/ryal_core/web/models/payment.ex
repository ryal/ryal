defmodule Ryal.Payment do
  use Ryal.Web, :model

  schema "ryal_payments" do
    field :number, :string
    field :state, :string, default: "pending"
    field :amount, :decimal

    belongs_to :order, Ryal.Order

    timestamps()
  end

  @required_fields ~w(amount)a
  @optional_fields ~w(number)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> generate_number
    |> validate_required(@required_fields)
    |> unique_constraint(:number)
  end

  def generate_number(changeset) do
    Ryal.Base33Calculator.change_number(changeset, "P")
  end
end
