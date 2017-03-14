defmodule Mix.Tasks.Ryal.Core.Install do
  @moduledoc "Installs all Ryal Core migrations."

  use Mix.Task

  def run(_) do
    File.mkdir_p project_migration_dir()

    stamp = String.to_integer timestamp()

    ryal_core_migrations()
    |> Stream.with_index
    |> Enum.each(fn({ryal_core_migration, index}) ->
      migration = "#{stamp + index}_#{migration_name(ryal_core_migration)}"
      copy_migration(ryal_core_migration, project_migration_dir(), migration)
    end)
  end

  defp ryal_core_migrations do
    :ryal_core
    |> :code.priv_dir
    |> Path.join("repo/migrations")
    |> Kernel.<>("/*.exs")
    |> Path.wildcard
    |> Enum.reject(&(&1 =~ ~r/ryal_core\.exs$/))
  end

  defp copy_migration(from, to, file_name) do
    if migration_exists?(to, file_name) do
      IO.puts "#{file_name} already exists."
    else
      File.cp_r!(from, "#{to}/#{file_name}")
      IO.puts "Copied #{file_name}"
    end
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)

  defp migration_exists?(to, file_name) do
    to
    <> "/*.exs"
    |> Path.wildcard
    |> Enum.map(&get_migration_name/1)
    |> Enum.member?(get_migration_name file_name)
  end

  defp project_migration_dir do
    Mix.Ecto.migrations_path Ryal.repo()
  end

  defp migration_name(migration) do
    name = get_migration_name(migration)
    [name | _] = String.split(name, ".")
    name <> ".ryal_core.exs"
  end

  defp get_migration_name(migration) do
    [<<_d::bytes-size(15)>> <> name | _] = migration
      |> String.split("/")
      |> Enum.reverse

    name
  end
end
