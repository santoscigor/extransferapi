defmodule Extransferapi.Repo do
  use Ecto.Repo,
    otp_app: :extransferapi,
    adapter: Ecto.Adapters.Postgres
end
