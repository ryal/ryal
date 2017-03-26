defmodule Dummy.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :dummy,
      config_path: "config/config.exs",
      version: "1.0.0",
      applications: applications(),
      build_embedded: false,
      start_permanent: false,
      compilers: [:phoenix] ++ Mix.compilers(),
      deps: [
        {:postgrex, ">= 0.13.0"},
        {:ecto, "~> 2.1"},
        {:phoenix, "~> 1.2.1"},
        {:phoenix_ecto, "~> 3.2.1"},
        {:scrivener_ecto, "~> 1.1"}
      ]
    ]
  end

  defp applications do
    [:ecto, :postgrex, :phoenix, :phoenix_ecto, :scrivener_ecto]
  end
end
