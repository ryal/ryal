use Mix.Config

config :ryal_core, ecto_repos: [Ryal.Repo]

import_config "#{Mix.env}.exs"
