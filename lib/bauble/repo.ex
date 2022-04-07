defmodule Bauble.Repo do
  use Ecto.Repo,
    otp_app: :bauble,
    adapter: Ecto.Adapters.Postgres
end
