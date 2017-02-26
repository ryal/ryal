defmodule Dummy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dummy,
      config_path: "config/config.exs",
      version: "0.0.0"
    ]
  end
end
