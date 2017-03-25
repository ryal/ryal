defmodule Ryal.PaymentTransition do
  use Ryal.Web, :model

  schema "ryal_payment_transitions" do
    field :from, :string
    field :to, :string
    field :event, :string
    field :result, :string

    belongs_to :payment, Ryal.Payment

    timestamps()
  end

  @required_fields ~w(from to event result)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
