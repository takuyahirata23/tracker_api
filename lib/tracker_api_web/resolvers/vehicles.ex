defmodule TrackerWeb.Resolvers.Vehicles do
  alias Tracker.Vehicle

  def get_makes(_, _, _) do
    {:ok, Vehicle.get_makes()}
  end
end
