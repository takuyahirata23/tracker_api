defmodule Tracker.Vehicle do
  import Ecto.Query, warn: false

  alias Tracker.Repo
  alias Tracker.Vehicle.{Make, Modal}

  def create_make(attrs) do
    %Make{}
    |> Make.changeset(attrs)
    |> Repo.insert()
  end

  def get_makes do
    Repo.all(Make)
  end

  def create_modal(attrs) do
    %Modal{}
    |> Modal.changeset(attrs)
    |> Repo.insert()
  end

  def get_make_by_id(id) when is_binary(id) do
    Make
    |> Repo.get_by(id: id)
    |> Repo.preload(:modals)
  end

  def get_makes do
    Make
    |> Repo.all()
  end
end
