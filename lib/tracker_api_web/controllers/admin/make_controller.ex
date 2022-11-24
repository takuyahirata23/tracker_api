defmodule TrackerWeb.Admin.MakeController do
  use TrackerWeb, :controller

  alias Tracker.Vehicle
  alias Tracker.Vehicle.Make

  def index(conn, _params) do
    makes = Vehicle.get_makes()

    render(conn, "index.html", makes: makes)
  end

  def new(conn, _params) do
    changeset = Make.changeset(%Make{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"make" => attrs}) do
    case Vehicle.create_make(attrs) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "New make created")
        |> redirect(to: Routes.make_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem creating a new make")
        |> render("new.html", changeset: changeset)
    end
  end
end
