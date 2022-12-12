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

  object :user_track do
    field :id, non_null(:id)
    field :track, non_null(:track)
  end

  object :track_queries do
    @desc "Get all of the tracks"
    field :tracks, list_of(non_null(:track)) do
      resolve(&TracksResolver.get_all_tracks/3)
    end

    @desc "Get all of user's tracks"
    field :user_tracks, list_of(non_null(:user_track)) do
      resolve(&TracksResolver.get_all_user_tracks/3)
    end

    @desc "Get user track by ID"
    field :user_track, :user_track do
      arg(:user_track_id, non_null(:string))
      resolve(&TracksResolver.get_user_track_by_id/3)
    end
  end

  object :track_mutations do
    @desc "Register user track"
    field :register_track, :user_track do
      arg(:track_id, non_null(:string))
      resolve(&TracksResolver.register_user_track/3)
    end
  end
end
