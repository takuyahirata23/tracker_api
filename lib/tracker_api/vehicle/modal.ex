defmodule Tracker.Vehicle.Modal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modals" do
    field :name, :string

    belongs_to :make, Tracker.Vehicle.Make

    timestamps()
  end

  def changeset(make, attrs \\ %{}) do
    make
    |> cast(attrs, [:name, :make_id])
    |> validate_required([:name, :make_id])
    |> validate_length(:name, min: 2, max: 50)
    |> assoc_constraint(:make)
    |> unique_constraint([:name, :make_id])
  end
end
