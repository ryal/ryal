defmodule Ryal.Repo do
  use Ecto.Repo, otp_app: :ryal_core
  use Scrivener, page_size: 20
end
