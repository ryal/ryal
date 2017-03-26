defmodule Dummy do
  @moduledoc false

  alias Dummy.Endpoint

  use Application

  @spec start(atom, list) :: Supervisor.on_start
  def start(_type, _args) do
    import Supervisor.Spec

    children = [supervisor(Dummy.Repo, []), supervisor(Endpoint, [])]

    opts = [strategy: :one_for_one, name: Dummy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec config_change(module, [], []) :: :ok
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
