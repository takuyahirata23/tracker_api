defmodule TrackerWeb.Schema.TrackTypes do
  use Absinthe.Schema.Notation

  alias TrackerWeb.Resolvers.Tracks, as: TracksResolver

  object :track do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string
    field :length, non_null(:float)
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)
  end

  object :track_queries do
    @desc "Get all the tracks"
    field :tracks, list_of(non_null(:track)) do
      resolve(&TracksResolver.get_all_tracks/3)
    end
  end
end
