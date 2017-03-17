defmodule Ryal do
  @repo Application.get_env(:ryal_core, :repo)

  if is_nil(@repo), do: raise "Ryal requires a repo."

  def repo, do: @repo
end
