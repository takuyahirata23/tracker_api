defmodule Tracker.Tracks.Track do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tracks" do
    field :name, :string
    field :description, :string
    field :length, :float
    field :latitude, :float
    field :longitude, :float

    timestamps()
  end

  def changeset(track, attrs \\ %{}) do
    track
    |> cast(attrs, [:name, :description, :length, :latitude, :longitude])
    |> validate_required([:name, :length, :latitude, :longitude])
    |> validate_length(:name, min: 2, max: 50)
    |> validate_length(:description, max: 200)
    |> unique_constraint(:name)
  end
end
