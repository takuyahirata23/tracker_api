defmodule TrackerWeb.Schema.BestLapTimeTypes do
  use Absinthe.Schema.Notation

  alias TrackerWeb.Resolvers.Record, as: RecordResolver

  object :best_lap_time do
    field :id, :id
    field :minutes, :integer
    field :seconds, non_null(:integer)
    field :miliseconds, non_null(:integer)
    field :date, non_null(:string)
  end

  input_object :best_lap_time_input do
    field :motorcycle_id, non_null(:string)
    field :user_track_id, non_null(:string)
    field :minutes, non_null(:integer)
    field :seconds, non_null(:integer)
    field :miliseconds, non_null(:integer)
    field :date, non_null(:string)
  end

  object :best_lap_time_queries do
    @desc "Get best lap times for specific track"
    field :best_lap_times, list_of(non_null(:best_lap_time)) do
      arg(:user_track_id, non_null(:string))
      resolve(&RecordResolver.get_best_lap_times_for_specific_track/3)
    end
  end

  object :best_lap_time_mutations do
    @desc "Save best lap time"
    field :save_best_lap_time, non_null(:best_lap_time) do
      arg(:best_lap_time_input, non_null(:best_lap_time_input))
      resolve(&RecordResolver.save_best_lap_time/3)
    end
  end
end
