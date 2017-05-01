defmodule Ryal.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ryal,
      version: "0.0.1",
      build_embedded: Mix.env == :prod,
      description: "An e-commerce library for elixir.",
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      package: package(),
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [applications: [:ryal_core, :logger]]
  end

  defp deps do
    [
      {:ryal_core, github: "ryal/ryal_core"},

      {:excoveralls, "~> 0.6", only: :test}
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
