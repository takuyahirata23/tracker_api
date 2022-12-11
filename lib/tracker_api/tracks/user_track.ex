defmodule Tracker.Tracks.UserTrack do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_tracks" do
    belongs_to :user, Tracker.Accounts.User
    belongs_to :track, Tracker.Tracks.Track

    timestamps()
  end

  def changeset(user_track, attrs \\ %{}) do
    user_track
    |> cast(attrs, [:user_id, :track_id])
    |> validate_required([:user_id, :track_id])
    |> unique_constraint([:user_id, :track_id], message: "You have already registed this track")
  end
end
