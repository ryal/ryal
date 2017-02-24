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
      elixir: "~> 1.3",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package,
      deps: deps,
      aliases: aliases
    ]
  end

  defp aliases do
    [
      "db.reset": [
        "ecto.drop",
        "ecto.create",
        "ecto.migrate"
      ]
    ]
  end

  def application do
    [applications: [:logger] ++ applications(Mix.env)]
  end

  defp applications(:test), do: [:postgrex, :ecto]
  defp applications(_), do: []

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:postgrex, "~> 0.13.0", optional: true}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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
