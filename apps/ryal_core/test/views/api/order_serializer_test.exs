defmodule Ryal.Api.OrderViewTest do
  use Ryal.ConnCase

  alias Dummy.User

  alias Ryal.Api.OrderView
  alias Ryal.Order

  test "renders show.json-api" do
    user = %User{}
      |> User.changeset(%{email: "ryal@example.com"})
      |> Repo.insert!

    order = %Order{}
      |> Order.changeset(%{user_id: user.id})
      |> Repo.insert!

    result = OrderView.render("show.json-api", data: order, conn: build_conn())

    assert result == %{
      "data" => %{
        "attributes" => %{
          "number" => order.number,
          "state" => "cart",
          "total" => 0.0
        },
        "id" => Poison.encode!(order.id),
        "type" => "order",
        "relationships" => %{
          "payments" => %{}
        }
      },
      "jsonapi" => %{
        "version" => "1.0"
      }
    }
  end
end
