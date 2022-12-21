defmodule TrackerWeb.Resolvers.Record do
  alias Tracer.Record

  alias TrackerWeb.ErrorHelpers

  def get_best_lap_times_for_specific_track(_, %{user_track_id: user_track_id}, _) do
    {:ok, Record.get_best_lap_times_by_user_track_id(user_track_id)}
  end

  def save_best_lap_time(_, %{best_lap_time_input: attrs}, _) do
    case Record.save_best_lap_time(attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error,
         %{
           message: "There was a problem registering a new vehicle",
           details: Ecto.Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
         }}

      {:ok, best_lap_time} ->
        {:ok, best_lap_time}
    end
  end
end
