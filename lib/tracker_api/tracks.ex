defmodule Tracker.Tracks do
  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.Tracks.Track

  def get_all_tracks do
    Repo.all(Track)
  end
end
