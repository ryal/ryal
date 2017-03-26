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
      compilers: compilers() ++ Mix.compilers,
      applications: applications()
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

  defp applications do
    [:phoenix, :phoenix_ecto, :logger, :ecto, :postgrex] ++ applications(Mix.env)
  end

  defp applications(:dev), do: [:dummy]
  defp applications(:test), do: [:dummy]
  defp applications(_), do: []

  defp compilers(), do: [:phoenix]

  defp deps do
    [
      {:dummy, path: "test/support/dummy", only: [:dev, :test], optional: true},
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:ja_serializer, "~> 0.12"},
      {:phoenix, "~> 1.2.1"},
      {:phoenix_ecto, "~> 3.2.1"},
      {:postgrex, ">= 0.13.0"},
      {:scrivener_ecto, "~> 1.1"}
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
