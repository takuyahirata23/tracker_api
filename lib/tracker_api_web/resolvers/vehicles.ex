defmodule TrackerWeb.Resolvers.Vehicles do
  alias Tracker.Vehicle
  alias TrackerWeb.ErrorHelpers

  def get_makes(_, _, _) do
    {:ok, Vehicle.get_makes()}
  end

  def get_modals_by_make_id(_, %{make_id: make_id}, _) do
    {:ok, Vehicle.get_modals_by_make_id(make_id)}
  end

  def get_user_vehicles(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Vehicle.get_user_vehicles(current_user.id)}
  end

  def register_user_vehicle(_, args, %{
        context: %{current_user: current_user}
      }) do
    attrs = Map.put(args, :user_id, current_user.id)

    case Vehicle.register_user_vehicle(attrs) do
      {:error, changeset} ->
        {:error,
         %{
           error: true,
           message: "There was a problem registering a new vehicle",
           errors: Ecto.Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
         }}

      {:ok, user_vehicle} ->
        {:ok, Vehicle.get_user_vehicle_by_id(user_vehicle.id)}
    end
  end
end
