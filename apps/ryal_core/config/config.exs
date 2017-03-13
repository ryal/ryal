use Mix.Config

config :ryal_core, ecto_repos: [Application.get_env(:ryal_core, :repo)]

import_config "#{Mix.env}.exs"
