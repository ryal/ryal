defmodule Ryal.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env == :prod,
      description: "An ecommerce library for elixir.",
      deps: deps,
      package: package,
      start_permanent: Mix.env == :prod
    ]
  end

  defp deps do
    []
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
