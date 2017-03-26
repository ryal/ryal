defmodule Dummy.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :dummy,
      elixirc_paths: ["lib", "web"],
      config_path: "config/config.exs",
      version: "1.0.0",
      build_embedded: false,
      start_permanent: false,
      compilers: [:phoenix] ++ Mix.compilers(),
      deps: [
        {:postgrex, ">= 0.0.0"},
        {:phoenix, "~> 1.2.1"},
        {:phoenix_ecto, "~> 3.2.1"},
        {:ja_serializer, "~> 0.12.0"},
        {:scrivener_ecto, "~> 1.1"}
      ]
    ]
  end

  def application do
    [
      mod: {Dummy, []},
      applications: [
        :ecto, :postgrex, :phoenix, :phoenix_ecto, :scrivener_ecto,
        :ja_serializer
      ]
    ]
  end
end
