defmodule TestMoning.Repo do
  use Ecto.Repo,
    otp_app: :test_moning,
    adapter: Ecto.Adapters.Postgres
end
