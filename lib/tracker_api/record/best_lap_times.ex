defmodule Tracker.Record.BestLapTime do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "best_lap_times" do
    field :minutes, :integer, default: 0
    field :seconds, :integer
    field :miliseconds, :integer
    field :date, :date

    belongs_to :motorcycle, Tracker.Vehicle.Motorcycle
    belongs_to :user_track, Tracker.Tracks.Track

    timestamps()
  end

  def changeset(best_lap_time, attrs \\ %{}) do
    best_lap_time
    |> cast(attrs, [:minutes, :seconds, :miliseconds, :date, :motorcycle_id, :user_track_id])
    |> validate_required([:minutes, :seconds, :miliseconds, :date, :motorcycle_id, :user_track_id])
  end
end
