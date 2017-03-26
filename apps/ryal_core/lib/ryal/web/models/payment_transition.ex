defmodule Ryal.PaymentTransition do
  @moduledoc """
  Each transition that a payment goes through is logged here. Ideally, a
  payment provider will log these as well, yet for accountants, this would act
  as a state of reconciliation. Think: here's our copy and here's the
  provider's copy.

  You can also use this as quick information to load up in a dashboard to
  present to both a user (payment transparency) and an admin.
  """

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
