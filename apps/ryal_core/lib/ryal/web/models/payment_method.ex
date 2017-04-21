defmodule Ryal.PaymentMethod do
  @moduledoc """
  A standard adapter to multiple payment methods.

  You can specify which payment you'd like to use via the `type` field and
  placing the data of a payment in a `data` field.

  The `data` resides within a `proxy` field which uses PostgreSQL's JSONB column
  to store the dynamic information. We use validations and whatnot at the
  application level to ensure the data is consistent. (Although, it would be
  nice is we could add constraints to PG later on.)

  ## Example

      iex> Ryal.PaymentMethod.changeset(%Ryal.PaymentMethod{}, %{
        type: "credit_card",
        user_id: 1,
        proxy: %{
          name: "Bobby Orr",
          number: "4242 4242 4242 4242",
          month: "03",
          year: "2048",
          cvc: "004"
        }
      })

      #Ecto.Changeset<action: nil,
       changes: %{ephemeral: %{cvc: "004", month: "03", name: "Bobby Orr",
           number: "4242 4242 4242 4242", year: "2048"},
         proxy: #Ecto.Changeset<action: :insert,
          changes: %{data: %{last_digits: "4242", month: "03",
              name: "Bobby Orr", year: "2048"}}, errors: [],
          data: #Ryal.PaymentMethod.Proxy<>, valid?: true>, type: "credit_card",
         user_id: 1}, errors: [], data: #Ryal.PaymentMethod<>, valid?: true>
  """

  use Ryal.Web, :model

  schema "ryal_payment_methods" do
    field :type, :string

    embeds_one :proxy, Ryal.PaymentMethod.Proxy
    field :ephemeral, :map, virtual: true

    has_many :payment_method_gateways, Ryal.PaymentMethodGateway

    belongs_to :user, Ryal.user_module()

    timestamps()
  end

  @required_fields ~w(type user_id)a
  @payment_method_types ~w(credit_card)

  @doc """
  You hand us a `proxy` of data and a `type` and we associate a payment method
  to a user.

  For an example on how to use this function, see the module description.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(set_module_type(params), @required_fields ++ [:ephemeral])
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @payment_method_types)
    |> cast_embed(:proxy, required: true)
  end

  defp set_module_type(%{type: type} = params)
      when type in @payment_method_types do
    module_type = Macro.camelize(type)
    {module_name, []} = Code.eval_string("Ryal.PaymentMethod.#{module_type}")

    all_data = Map.get(params, :proxy, %{})
    proxy_data = struct(module_name, all_data)

    params
    |> Map.put(:proxy, proxy_data)
    |> Map.put(:ephemeral, all_data)
  end

  defp set_module_type(params), do: params
end
