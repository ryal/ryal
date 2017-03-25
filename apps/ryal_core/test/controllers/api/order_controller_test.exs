defmodule Ryal.Api.OrderControllerTest do
  use Ryal.ApiCase

  alias Dummy.User

  alias Ryal.Api.OrderView
  alias Ryal.Order

  describe "index/2" do
    test "will list orders", %{conn: conn} do
      user = %User{}
        |> User.changeset(%{email: "ryal@example.com"})
        |> Repo.insert!

      %Order{}
      |> Order.changeset(%{user_id: user.id})
      |> Repo.insert!

      conn = get(conn, order_path(conn, :index))
      orders = Repo.paginate(Order)

      order_json = render_json(OrderView, "index", data: orders, conn: conn)
      assert json_response(conn, 200) == order_json
    end
  end
end
