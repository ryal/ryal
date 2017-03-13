defmodule Ryal.JsonRenderPlug do
  @moduledoc """
  This module contains functions for rendering objects in the API. They're meant
  to make your life as a developer easier and the code far more maintainable. It
  also means managing the JSON API integration quite a lot easier as well.
  """

  alias Ecto.Queryable
  alias Phoenix.Controller
  alias Plug.Conn
  alias Dummy.Repo, as: Repo
  alias Ryal.JsonApiQuery

  def render_collection(conn, params, collection) do
    tenant = conn.assigns[:subdomain]
    prefix = if tenant, do: "tenant_#{tenant}", else: "public"

    data = collection
      |> Queryable.to_query
      |> Map.put(:prefix, prefix)
      |> JsonApiQuery.filter(params["filter"], Controller.view_module(conn))
      |> JsonApiQuery.sort(params["sort"], Controller.view_module(conn))
      |> Repo.paginate(params["page"])

    Controller.render conn, data: data, opts: [
      fields: params["fields"],
      include: params["include"]
    ]
  end

  def render_instance(conn, params, instance) do
    opts = [fields: params["fields"], include: params["include"]]
    Controller.render conn, :show, data: instance, opts: opts
  end

  def render_creation(conn, params, response) do
    case response do
      {:ok, result} ->
        conn
        |> Conn.put_status(201)
        |> render_instance(params, result)
      {:error, changeset} ->
        conn
        |> Conn.put_status(422)
        |> Controller.render(:errors, data: changeset)
    end
  end

  def render_deletion(conn, _params, response) do
    case response do
      {:ok, _result} ->
        Conn.send_resp(conn, 204, "")
      {:error, _changeset} ->
        Conn.send_resp(conn, 422, "")
    end
  end
end
