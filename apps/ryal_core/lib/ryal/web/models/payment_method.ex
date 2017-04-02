defmodule Ryal.PaymentMethod do
  @moduledoc """
  A standard adapter to multiple payment methods.

  You can specify which payment you'd like to use via the `type` field and
  placing the data of a payment in the `data` field.

  The `data` field uses PostgreSQL's JSONB column to store the dynamic
  information. We use validations and whatnot at the application level to ensure
  the data is consistent. (Although, it would be nice is we could add
  constraints to PG later on.)

  ## Example

      iex> Ryal.PaymentMethod.changeset(%Ryal.PaymentMethod{}, %{
        type: "credit_card",
        data: %{
          name: "Bobby Orr",
          number: "4242 4242 4242 4242",
          month: "03",
          year: "2048",
          cvc: "004"
        }
      })

      #Ecto.Changeset<action: nil,
       changes: %{data: #Ecto.Changeset<action: :insert,
          changes: %{cvc: "123", month: "03", name: "Bobby Orr",
            number: "4242 4242 4242", year: "2048"}, errors: [],
          data: #Ryal.PaymentMethod.CreditCard<>, valid?: true>,
          type: "credit_card"},
       errors: [], data: #Ryal.PaymentMethod<>, valid?: true>
  """

  use Ryal.Web, :model

  schema "ryal_payment_methods" do
    field :type, :string

    embeds_one :data, Ryal.PaymentMethod.Proxy

    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()
  end

  @required_fields ~w(type user_id)a
  @payment_method_types ~w(credit_card)

  @doc """
  You hand us some `data` and a `type` and we associate a payment method to a
  user.

  For an example on how to use this function, see the module description.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(set_module_type(params), @required_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @payment_method_types)
    |> cast_embed(:data, required: true)
  end

  defp set_module_type(%{type: type} = params)
      when type in @payment_method_types do
    module_type = Macro.camelize(type)
    {module_name, []} = Code.eval_string("Ryal.PaymentMethod.#{module_type}")
    data = Map.get(params, :data, %{})
    Map.put(params, :data, struct(module_name, data))
  end

  defp set_module_type(params), do: params
end
