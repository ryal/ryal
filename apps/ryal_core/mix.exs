defmodule Ryal.Core.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ryal_core,
      description: "The core of Ryal.",
      version: "0.1.0",
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
        "ecto.migrate -r Dummy.Repo"
      ]
    ]
  end

  def applications do
    [:phoenix, :phoenix_ecto, :logger, :ecto, :postgrex] ++ applications(Mix.env)
  end

  defp applications(:test), do: [:dummy]
  defp applications(_), do: []

  defp compilers(), do: [:phoenix]

  defp deps do
    [
      {:dummy, path: "test/support/dummy", only: :test},
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:ja_serializer, "~> 0.12"},
      {:phoenix, "~> 1.2.1"},
      {:phoenix_ecto, "~> 3.2.1"},
      {:postgrex, ">= 0.13.0", optional: true},
      {:scrivener_ecto, "~> 1.1"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  defp package do
    [
      maintainers: ["Ben A. Morgan"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/ryal/ryal"},
      files: [
        "lib/ryal",
        "mix.exs",
        "README.md"
      ]
    ]
  end
end
