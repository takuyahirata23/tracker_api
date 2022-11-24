defmodule Tracker.Vehicle.Make do
  use Ecto.Schema
  import Ecto.Changeset

  schema "makes" do
    field :name, :string
    timestamps()
  end

  def changeset(makes, attrs) do
    makes
    |> cast(attrs, [:name])
    |> validate_length(:name, min: 2, max: 30)
  end
end
