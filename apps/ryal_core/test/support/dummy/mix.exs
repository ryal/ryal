defmodule Dummy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dummy,
      config_path: "config/config.exs",
      version: "1.0.0",
      applications: [:ecto, :postgrex, :phoenix, :phoenix_ecto, :scrivener_ecto],
      deps: [
        {:postgrex, ">= 0.13.0"},
        {:ecto, "~> 2.1"},
        {:phoenix, "~> 1.2.1"},
        {:phoenix_ecto, "~> 3.2.1"},
        {:scrivener_ecto, "~> 1.1"}
      ]
    ]
  end
end
