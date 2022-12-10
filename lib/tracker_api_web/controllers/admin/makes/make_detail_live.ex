defmodule TrackerWeb.MakeDetailLive do
  use TrackerWeb, :live_view

  alias Tracker.AdminVehicle

  alias TrackerWeb.{
    ModalComponent,
    ModalForm
  }

  def mount(%{"make_id" => make_id}, _, socket) do
    {:ok, assign(socket, make_id: make_id)}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        ModalComponent.show_modal(%{
          module: ModalForm,
          show: true,
          make_id: socket.assigns.make_id
        })

      _ ->
        ModalComponent.close_modal()
    end

    make = AdminVehicle.admin_get_make_by_id(socket.assigns.make_id)
    {:noreply, assign(socket, make: make)}
  end
end
