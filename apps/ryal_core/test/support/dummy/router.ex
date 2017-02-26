defmodule Dummy.Router do
  use Ryal.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]

    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", Ryal.Api do
    pipe_through :api

    resources "/orders", OrderController, only: [:index, :create, :show, :update, :delete]
  end
end
