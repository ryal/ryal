defmodule Mix.Tasks.Ryal.Install do
  @moduledoc "Installs all Ryal migrations."

  use Mix.Task

  alias Mix.Tasks.Ryal.Core.Install, as: Core

  def run(args) do
    Core.run(args)
  end
end
