defmodule Ryal do
  @repo Application.get_env(:ryal_core, :repo)
  @user_module Application.get_env(:ryal_core, :user_module)
  @user_table Application.get_env(:ryal_core, :user_table)

  def repo, do: @repo
  def user_module, do: @user_module
  def user_table, do: @user_table
end
