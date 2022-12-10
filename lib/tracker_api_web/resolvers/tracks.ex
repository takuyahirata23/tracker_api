defmodule TrackerWeb.Resolvers.Tracks do
  alias Tracker.Tracks

  def get_all_tracks(_, _, _) do
    {:ok, Tracks.get_all_tracks()}
  end
end
