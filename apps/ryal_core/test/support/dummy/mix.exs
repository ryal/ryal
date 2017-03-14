defmodule Dummy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dummy,
      config_path: "config/config.exs",
      version: "1.0.0",
      deps: [
        {:ecto, "~> 2.1"},
        {:postgrex, ">= 0.13.0"}
      ]
    ]
  end
end
