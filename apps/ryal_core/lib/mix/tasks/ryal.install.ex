defmodule Mix.Tasks.Ryal.Install do
  @moduledoc "Installs all Ryal migrations."

  use Mix.Task

  def run(args) do
    Mix.Tasks.Ryal.Core.Install.run(args)
  end
end
