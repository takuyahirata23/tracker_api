defmodule Tracker.Vehicle do
  import Ecto.Query, warn: false

  alias Tracker.Repo
  alias Tracker.Vehicle.{Make, Modal, UserVehicle}

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

  def register_user_vehicle(attrs) do
    %UserVehicle{}
    |> UserVehicle.changeset(attrs)
    |> Repo.insert()
  end

  def get_make_by_id(id) when is_binary(id) do
    Make
    |> Repo.get_by(id: id)
  end

  def get_user_vehicle_by_id(id) when is_binary(id) do
    UserVehicle
    |> join(:inner, [uv], ma in Make, on: uv.make_id == ma.id)
    |> join(:inner, [uv, ma], mo in Modal, on: uv.modal_id == mo.id)
    |> select([uv, ma, mo], %{id: uv.id, make: ma.name, modal: mo.name, year: uv.year})
    |> Repo.get_by(id: id)
  end

  def get_user_vehicles(user_id) when is_binary(user_id) do
    UserVehicle
    |> where([uv], uv.user_id == ^user_id)
    |> join(:inner, [uv], ma in Make, on: uv.make_id == ma.id)
    |> join(:inner, [uv, ma], mo in Modal, on: uv.modal_id == mo.id)
    |> select([uv, ma, mo], %{id: uv.id, make: ma.name, modal: mo.name, year: uv.year})
    |> Repo.all()
  end
end
