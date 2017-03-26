defmodule Ryal.Api.OrderController do
  use Ryal.Web, :controller

  alias Ryal.Order

  def index(conn, params) do
    render_collection conn, params, Order
  end
end
