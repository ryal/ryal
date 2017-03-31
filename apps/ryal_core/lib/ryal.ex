defmodule Ryal do
  @moduledoc """
  The core Ryal namespace. This guy is primarily used for configuration.
  """

  @repo Application.get_env(:ryal_core, :repo)
  @user_module Application.get_env(:ryal_core, :user_module)
  @user_table Application.get_env(:ryal_core, :user_table)

  use Application

  def repo, do: @repo
  def user_module, do: @user_module
  def user_table, do: @user_table

  @spec start(atom, list) :: Supervisor.on_start
  def start(:normal, []) do
    Supervisor.start_link([], [strategy: :one_for_one, name: Ryal.Supervisor])
  end
end
