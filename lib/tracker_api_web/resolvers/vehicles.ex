defmodule TrackerWeb.Resolvers.Vehicles do
  alias Tracker.Vehicle

  def get_vehicles(_, _, _) do
    {:ok, Vehicle.get_vehicles()}
  end
end
