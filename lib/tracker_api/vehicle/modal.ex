defmodule Tracker.Vehicle.Modal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modal" do
    field :name, :string

    belongs_to :make, Tracker.Vehicle.Make

    timestamps()
  end

  def changeset(make, attrs) do
    make
    |> cast(attrs, [:name])
    |> validate_length(:name, min: 2, max: 50)
    |> assoc_constraint(:make)
  end
end
