defmodule Ryal.Api.OrderControllerTest do
  use Ryal.ApiCase

  alias Ryal.Api.OrderView
  alias Ryal.Order

  describe "index/2" do
    test "will list orders", %{conn: conn} do
      %Order{}
      |> Order.changeset
      |> Repo.insert!

      conn = get(conn, order_path(conn, :index))
      orders = Repo.paginate(Order)

      order_json = render_json(OrderView, "index", data: orders, conn: conn)
      assert json_response(conn, 200) == order_json
    end
  end
end
