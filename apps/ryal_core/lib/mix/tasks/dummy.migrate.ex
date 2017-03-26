defmodule Mix.Tasks.Dummy.Migrate do
  @moduledoc "Runs all Dummy migrations."

  alias Ecto.Migrator
  alias Dummy.Repo

  use Mix.Task

  def run(_args) do
    {:ok, _} = Application.ensure_all_started(:dummy)
    {:ok, _} = Repo.start_link(pool_size: 1)

    path = Application.app_dir(:dummy, "priv/repo/migrations")
    Migrator.run(Repo, path, :up, all: true)
  end
end
