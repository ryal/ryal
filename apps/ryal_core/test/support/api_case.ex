defmodule Ryal.ApiCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest

      alias Dummy.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Dummy.Router.Helpers

      @endpoint Dummy.Endpoint

      def render_json(view, template, assigns) do
        template
        <> ".json-api"
        |> view.render(assigns)
        |> format_json
      end

      def render_error(changeset, conn) do
        changeset.errors
        |> JaSerializer.EctoErrorSerializer.format(conn)
        |> format_json
      end

      defp format_json(data) do
        data
        |> Poison.encode!
        |> Poison.decode!
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Dummy.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Dummy.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn
    conn = %{conn | host: "api.example.com"}
      |> Plug.Conn.put_req_header("accept", "application/vnd.api+json")
      |> Plug.Conn.put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
end
