defmodule Ryal.Core.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExUnit.Case, unquote(opts)
      import Ecto.Query
    end
  end

  setup do
    Ecto.Adapters.SQL.Sandbox.mode(Ryal.Repo, :manual)

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ryal.Repo)
  end
end

Ryal.Repo.start_link
ExUnit.start()
