{:ok, _} = Dummy.Repo.__adapter__.ensure_all_started(Dummy.Repo, :temporary)
{:ok, _} = Dummy.Repo.start_link(pool_size: 1)

Ecto.Adapters.SQL.Sandbox.mode(Dummy.Repo, :manual)

ExUnit.start()
