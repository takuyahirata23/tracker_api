defmodule TrackerWeb.Resolvers.Vehicles do
  alias Tracker.Vehicle
  alias TrackerWeb.ErrorHelpers

  def get_makes(_, _, _) do
    {:ok, Vehicle.get_makes()}
  end

  def get_modals_by_make_id(_, %{make_id: make_id}, _) do
    {:ok, Vehicle.get_modals_by_make_id(make_id)}
  end

  def get_motorcycles(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Vehicle.get_motorcycles(current_user.id)}
  end

  def register_motorcycle(_, %{motorcycle_input: attrs}, %{
        context: %{current_user: current_user}
      }) do
    attrs = Map.put(attrs, :user_id, current_user.id)

    case Vehicle.register_motorcycle(attrs) do
      {:error, changeset} ->
        {:error,
         %{
           message: "There was a problem registering a new vehicle",
           details: Ecto.Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
         }}

      {:ok, motorcycle} ->
        {:ok, Vehicle.get_motorcycle_by_id(motorcycle.id)}
    end
  end
end
