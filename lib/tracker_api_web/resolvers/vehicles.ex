defmodule TrackerWeb.Resolvers.Vehicles do
  alias Tracker.Vehicle

  def get_makes(_, _, _) do
    {:ok, Vehicle.get_makes()}
  end

  def get_user_vehicles(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Vehicle.get_user_vehicles(current_user.id)}
  end

  def register_user_vehicle(_, args, %{
        context: %{current_user: current_user}
      }) do
    attrs = Map.put(args, :user_id, current_user.id)
    Vehicle.register_user_vehicle(attrs)
  end
end
