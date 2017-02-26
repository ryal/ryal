use Mix.Config

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, :format_encoders, "json-api": Poison

config :dummy, Dummy.Endpoint,
  http: [port: 4001],
  server: false,
  url: [host: "localhost"],
  secret_key_base: "testing123",
  render_errors: [view: Dummy.ErrorView, accepts: ~w(html json json-api)]
