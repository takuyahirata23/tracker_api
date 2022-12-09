defmodule Tracker.Vehicle.UserVehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_vehicles" do
    field :year, :integer

    belongs_to :user, Tracker.Accounts.User
    belongs_to :make, Tracker.Vehicle.Make
    belongs_to :modal, Tracker.Vehicle.Modal

    timestamps()
  end

  def changeset(user_vehicle, attrs) do
    user_vehicle
    |> cast(attrs, [:year, :user_id, :modal_id, :make_id])
    |> validate_required([:year, :user_id, :modal_id, :make_id])
  end
end
