defmodule Ryal.Order do
  use Ryal.Web, :model

  schema "ryal_orders" do
    field :number, :string
    field :state, :string, default: "cart"
    field :total, :decimal

    timestamps()
  end

  @required_fields ~w()a
  @optional_fields ~w(number state total)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> generate_number
    |> validate_required(@required_fields)
    |> unique_constraint(:number)
  end

  def generate_number(changeset) do
    Ryal.Base33Calculator.change_number(changeset, "R")
  end
end
