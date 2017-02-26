defmodule Ryal.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env == :prod,
      description: "An ecommerce library for elixir.",
      deps: deps(),
      package: package(),
      start_permanent: Mix.env == :prod
    ]
  end

  def application do
    [applications: [:ryal_core, :logger]]
  end

  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:postgrex, "~> 0.13.0", optional: true},

      {:ryal_core, path: "apps/ryal_core", from_umbrella: true, env: Mix.env, manager: :mix}
    ]
  end

  defp package do
    [
      maintainers: ["Ben A. Morgan"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/ryal/ryal"},
      files: [
        "mix.exs",
        "README.md"
      ]
    ]
  end
end
