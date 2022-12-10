defmodule TrackerWeb.TrackForm do
  use TrackerWeb, :live_component

  alias Tracker.AdminTrack
  alias Tracker.Tracks.Track

  def update(_, socket) do
    changeset = Track.changeset(%Track{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("new-track", %{"track" => attrs}, socket) do
    case AdminTrack.create_track(attrs) do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}

      {:ok, _} ->
        socket = socket |> put_flash(:info, "New track created")
        {:noreply, push_patch(socket, to: Routes.track_path(socket, :index))}
    end
  end
end
