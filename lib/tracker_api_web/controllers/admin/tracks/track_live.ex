defmodule TrackerWeb.TrackLive do
  use TrackerWeb, :live_view

  alias Tracker.AdminTrack

  alias TrackerWeb.{
    ModalComponent,
    TrackForm
  }

  def mounct(_, _, socket) do
    {:ok, socket}
  end

  def handle_params(_, _, socket) do
    case socket.assigns.live_action do
      :new ->
        ModalComponent.show_modal(%{
          module: TrackForm,
          show: true
        })

      _ ->
        ModalComponent.close_modal()
    end

    tracks = AdminTrack.get_all_tracks()
    {:noreply, assign(socket, tracks: tracks)}
  end
end
