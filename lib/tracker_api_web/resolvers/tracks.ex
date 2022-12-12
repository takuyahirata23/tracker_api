defmodule TrackerWeb.Resolvers.Tracks do
  alias TrackerWeb.ErrorHelpers
  alias Tracker.Tracks

  def register_user_track(_, %{track_id: track_id}, %{context: %{current_user: current_user}}) do
    attrs = %{user_id: current_user.id, track_id: track_id}

    case Tracks.register_user_track(attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error,
         %{
           message: "There was a problem registering a new track",
           details: Ecto.Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
         }}

      {:ok, user_track} ->
        {:ok, Tracks.get_user_track_by_id(user_track.id)}
    end
  end

  def get_all_tracks(_, _, _) do
    {:ok, Tracks.get_all_tracks()}
  end

  def get_all_user_tracks(_, _, %{context: %{current_user: current_user}}) do
    {:ok, Tracks.get_all_user_tracks_by_id(current_user.id)}
  end

  def get_user_track_by_id(_, %{user_track_id: user_track_id}, _) do
    {:ok, Tracks.get_user_track_by_id(user_track_id)}
  end
end
