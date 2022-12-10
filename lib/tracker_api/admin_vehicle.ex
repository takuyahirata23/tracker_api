defmodule Tracker.AdminVehicle do
  import Ecto.Query, warn: false

  alias Tracker.Repo
  alias Tracker.Vehicle.{Make}

  def admin_get_make_by_id(id) when is_binary(id) do
    Make
    |> Repo.get_by(id: id)
    |> Repo.preload(:modals)
  end
end
