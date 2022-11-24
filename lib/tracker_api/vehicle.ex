defmodule Tracker.Vehicle do
  import Ecto.Query, warn: false

  alias Tracker.Repo
  alias Tracker.Vehicle.{Make}

  def create_make(attrs) do
    %Make{}
    |> Make.changeset(attrs)
    |> Repo.insert()
  end

  def get_makes do
    Repo.all(Make)
  end
end
