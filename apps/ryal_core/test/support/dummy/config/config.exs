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

config :dummy, Dummy.Repo,
  priv: "../ryal_core/priv/repo",
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "dummy_#{Mix.env}",
  username: System.get_env("DUMMY_DB_USER") || System.get_env("USER")

config :ryal_core,
  repo: Dummy.Repo,
  user_module: Dummy.User,
  user_table: :users
