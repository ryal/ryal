defmodule Ryal.Api.OrderView do
  @moduledoc "View for serializing a `Ryal.Order`"

  use Ryal.Web, :view
  use JaSerializer.PhoenixView

  attributes [:number, :state, :total]

  has_many :payments
end
