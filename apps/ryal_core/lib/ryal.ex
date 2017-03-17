defmodule Ryal do
  @repo Application.get_env(:ryal_core, :repo)

  def repo, do: @repo
end
