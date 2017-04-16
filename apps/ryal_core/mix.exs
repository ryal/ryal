defmodule Ryal.Core.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ryal_core,
      description: "The core of Ryal.",
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
      aliases: aliases(),
      compilers: [:phoenix] ++ Mix.compilers,
      test_coverage: [tool: ExCoveralls]
    ]
  end

  defp aliases do
    [
      "db.reset": [
        "ecto.drop -r Dummy.Repo",
        "ecto.create -r Dummy.Repo",
        "dummy.migrate",
        "ecto.migrate -r Dummy.Repo"
      ]
    ]
  end

  def application do
    [
      mod: {Ryal, []},
      applications: applications() ++ applications(Mix.env)
    ]
  end

  defp applications do
    [
      :phoenix, :phoenix_ecto, :logger, :ecto, :postgrex, :scrivener,
      :scrivener_ecto, :httpotion
    ]
  end

  defp applications(:dev), do: [:dummy]
  defp applications(:test), do: [:bypass, :dummy]
  defp applications(_), do: []

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:ja_serializer, "~> 0.12"},
      {:phoenix, "~> 1.2.1"},
      {:phoenix_ecto, "~> 3.2.1"},
      {:postgrex, ">= 0.13.0"},
      {:scrivener_ecto, "~> 1.1"},
      {:httpotion, "~> 3.0.2"},
      {:bypass, "~> 0.6", only: :test},

      {:dummy, path: "test/support/dummy", only: [:dev, :test], optional: true}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Ben A. Morgan"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/ryal/ryal"},
      files: ~w(config/config.exs lib priv web mix.exs LICENSE.txt README.md)
    ]
  end
end
