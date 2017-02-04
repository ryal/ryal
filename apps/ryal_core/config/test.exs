use Mix.Config

config :ryal_core, ecto_repos: [Ryal.Repo]

config :ryal_core, Ryal.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "ryal_test",
  username: System.get_env("RYAL_DB_USER") || System.get_env("USER")

config :logger, :console,
  level: :error
