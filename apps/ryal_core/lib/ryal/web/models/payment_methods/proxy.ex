defmodule Ryal.PaymentMethod.Proxy do
  @moduledoc """
  When passing data into a `Ryal.PaymentMethod`, this module detects the struct
  and uses the appropriate changeset and embedded schema. It's what a proxy
  does. :D
  """

  use Ecto.Schema

  import Ecto.Changeset, only: [cast: 3]

  embedded_schema do
    field :data, :map
  end

  @doc """
  This changeset particularly just converts the struct received into a changeset
  specific to that struct's module.

  If the struct provided is a map (you forgot to specify a `type` for a
  `Ryal.PaymentMethod`), then we really just return a cast of the proxy.

  We use `map_size/1` here as a guard because both a struct and a map would pass
  an `is_map/1` check. So, we check the size! Structs have at least `8`, whereas
  maps can actually reach `0`:

      iex> map_size %CreditCard{}
      8

      iex> map_size %{}
      0

  """
  def changeset(proxy, struct) when map_size(struct) == 0 do
    cast(proxy, %{}, [])
  end

  def changeset(_proxy, struct) do
    %module{} = struct
    params = Map.from_struct(struct)

    proxy_changeset = module
      |> struct(%{})
      |> module.changeset(params)

    %__MODULE__{}
    |> cast(%{data: params}, [:data])
    |> Map.merge(%{
      changes: %{data: proxy_changeset.changes},
      errors: proxy_changeset.errors,
      valid?: proxy_changeset.valid?
    })
  end
end
