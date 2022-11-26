defmodule TrackerWeb.MakeLive do
  use TrackerWeb, :live_view

  alias Tracker.Vehicle

  alias TrackerWeb.{
    ModalComponent,
    MakeForm
  }

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        ModalComponent.show_modal(%{
          module: MakeForm,
          show: true
        })

      _ ->
        ModalComponent.close_modal()
    end

    makes = Vehicle.get_makes()
    {:noreply, assign(socket, makes: makes)}
  end
end
