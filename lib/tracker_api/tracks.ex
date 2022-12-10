defmodule Tracker.Tracks do
  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.Tracks.{Track, UserTrack}

  def register_user_track(attrs) do
    %UserTrack{}
    |> UserTrack.changeset(attrs)
    |> Repo.insert()
  end

  def get_user_track_by_id(id) when is_binary(id) do
    UserTrack
    |> where([ut], ut.id == ^id)
    |> join(:inner, [ut], t in Track, on: ut.track_id == t.id)
    |> select([ut, t], %{id: ut.id, track: t})
    |> Repo.get_by(id: id)
  end

  def get_all_tracks do
    Repo.all(Track)
  end

  def get_all_user_tracks_by_id(id) when is_binary(id) do
    UserTrack
    |> where([ut], ut.user_id == ^id)
    |> join(:inner, [ut], t in Track, on: ut.track_id == t.id)
    |> select([ut, t], %{id: ut.id, track: t})
    |> Repo.all()
  end
end
