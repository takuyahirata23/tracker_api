defmodule Tracker.Vehicle.Motorcycle do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "motorcycles" do
    field :year, :integer

    belongs_to :user, Tracker.Accounts.User
    belongs_to :make, Tracker.Vehicle.Make
    belongs_to :modal, Tracker.Vehicle.Modal

    timestamps()
  end

  def changeset(motorcycle, attrs) do
    motorcycle
    |> cast(attrs, [:year, :user_id, :modal_id, :make_id])
    |> validate_required([:year, :user_id, :modal_id, :make_id])
    |> unique_constraint([:user_id, :modal_id, :year, :make_id],
      message: "You have already registerd this vehicle"
    )
  end
end
