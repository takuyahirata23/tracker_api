defmodule Tracker.Repo do
  use Ecto.Repo,
    otp_app: :tracker_api,
    adapter: Ecto.Adapters.Postgres
end
