defmodule TrackerWeb.MakeForm do
  use TrackerWeb, :live_component

  alias Tracker.Vehicle
  alias Tracker.Vehicle.Make

  def update(_, socket) do
    changeset = Make.changeset(%Make{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("new-make", %{"make" => attrs}, socket) do
    case Vehicle.create_make(attrs) do
      {:ok, _} ->
        socket = socket |> put_flash(:info, "New make created")
        {:noreply, push_patch(socket, to: Routes.make_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
