{:ok, _} = Dummy.Repo.__adapter__.ensure_all_started(Dummy.Repo, :temporary)

Ecto.Adapters.SQL.Sandbox.mode(Dummy.Repo, :manual)

ExUnit.start()
