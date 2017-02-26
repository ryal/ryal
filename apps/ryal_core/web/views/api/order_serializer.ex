defmodule Ryal.Api.OrderView do
  use Ryal.Web, :view
  use JaSerializer.PhoenixView

  attributes [:number, :state, :total]

  has_many :payments
end
