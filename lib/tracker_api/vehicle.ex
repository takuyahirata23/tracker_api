defmodule Tracker.Vehicle do
  import Ecto.Query, warn: false

  alias Tracker.Repo
  alias Tracker.Vehicle.{Make, Modal, Motorcycle}

  def create_make(attrs) do
    %Make{}
    |> Make.changeset(attrs)
    |> Repo.insert()
  end

  def get_makes() do
    Repo.all(Make)
  end

  def get_modals_by_make_id(make_id) when is_binary(make_id) do
    Modal
    |> where([m], m.make_id == ^make_id)
    |> Repo.all()
  end

  def create_modal(attrs) do
    %Modal{}
    |> Modal.changeset(attrs)
    |> Repo.insert()
  end

  def register_motorcycle(attrs) do
    %Motorcycle{}
    |> Motorcycle.changeset(attrs)
    |> Repo.insert()
  end

  def get_motorcycle_by_id(id) when is_binary(id) do
    Motorcycle
    |> join(:inner, [uv], ma in Make, on: uv.make_id == ma.id)
    |> join(:inner, [uv, ma], mo in Modal, on: uv.modal_id == mo.id)
    |> select([uv, ma, mo], %{id: uv.id, make: ma.name, modal: mo.name, year: uv.year})
    |> Repo.get_by(id: id)
  end

  def get_motorcycles(user_id) when is_binary(user_id) do
    Motorcycle
    |> where([uv], uv.user_id == ^user_id)
    |> join(:inner, [uv], ma in Make, on: uv.make_id == ma.id)
    |> join(:inner, [uv, ma], mo in Modal, on: uv.modal_id == mo.id)
    |> select([uv, ma, mo], %{id: uv.id, make: ma.name, modal: mo.name, year: uv.year})
    |> Repo.all()
  end
end
