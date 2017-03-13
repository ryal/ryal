use Mix.Config

config :logger, level: :warn

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, :format_encoders, "json-api": Poison

import_config "../test/support/dummy/config/config.exs"
