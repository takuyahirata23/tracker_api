defmodule TrackerWeb.ModalForm do
  use TrackerWeb, :live_component

  alias Tracker.Vehicle
  alias Tracker.Vehicle.Modal

  def update(%{make_id: make_id}, socket) do
    changeset = Modal.changeset(%Modal{})
    {:ok, assign(socket, changeset: changeset, make_id: make_id)}
  end

  def handle_event("new-modal", %{"modal" => attrs}, socket) do
    make_id = socket.assigns.make_id
    modal = Map.put(attrs, "make_id", make_id)

    case Vehicle.create_modal(modal) do
      {:ok, _} ->
        socket = socket |> put_flash(:info, "New modal created")

        {:noreply, push_patch(socket, to: Routes.make_detail_path(socket, :show, make_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
