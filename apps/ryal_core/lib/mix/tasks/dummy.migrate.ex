defmodule Mix.Tasks.Dummy.Migrate do
  @moduledoc "Runs all Dummy migrations."

  alias Ecto.Migrator
  alias Dummy.Repo

  use Mix.Task

  def run(_args) do
    {:ok, _} = Application.ensure_all_started(:dummy)

    path = Application.app_dir(:dummy, "priv/repo/migrations")
    Migrator.run(Repo, path, :up, all: true)
  end
end
