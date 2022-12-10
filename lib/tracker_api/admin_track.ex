defmodule Tracker.AdminTrack do
  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.Tracks.Track

  def create_track(attrs) do
    %Track{}
    |> Track.changeset(attrs)
    |> Repo.insert()
  end

  def get_all_tracks do
    Repo.all(Track)
  end
end
