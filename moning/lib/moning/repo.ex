defmodule Moning.Repo do
  use Ecto.Repo,
    otp_app: :moning,
    adapter: Ecto.Adapters.Postgres
end
