defmodule Tracker.Vehicle.Make do
  use Ecto.Schema
  import Ecto.Changeset

  schema "makes" do
    field :name, :string

    has_many :modals, Tracker.Vehicle.Modal

    timestamps()
  end

  def changeset(makes, attrs \\ %{}) do
    makes
    |> cast(attrs, [:name])
    |> validate_length(:name, min: 2, max: 30)
    |> unique_constraint(:name, message: "#{attrs["name"]} already exists")
  end
end
