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

  def render(assigns) do
    ~H"""
    <div>
    <h3 class="font-bold text-lg mb-4">Create new make</h3>
    <.form :let={f} for={@changeset} phx-submit="new-make" action="#" class="flex flex-col gap-x-4" phx-target={@myself}>
    <div>
    <div class="flex flex-col">
    <%= label f, :name %>
    <%= text_input f, :name, required: true , class: "bg-bg-secondary/10"%>
    <%= error_tag f, :name %>
    </div>
    </div>
    <div>
    <%= submit "Create" %>
    </div>
    </.form>
    </div>
    """
  end
end
