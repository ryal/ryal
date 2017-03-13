defmodule Dummy.Repo do
  use Ecto.Repo, otp_app: :dummy
  use Scrivener, page_size: 20
end
