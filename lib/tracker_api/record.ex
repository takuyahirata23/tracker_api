defmodule Tracer.Record do
  import Ecto.Query, warn: false
  alias Tracker.Repo

  alias Tracker.Record.BestLapTime

  def get_best_lap_times_by_user_track_id(id) when is_binary(id) do
    BestTimeLap
    |> where([btl], btl.user_track_id == ^id)
    |> Repo.all()
  end

  def save_best_lap_time(attrs) do
    case get_best_lap_time_for_a_day(attrs.date, attrs.motorcycle_id, attrs.user_track_id) do
      nil ->
        %BestLapTime{}
        |> BestLapTime.changeset(attrs)
        |> Repo.insert()

      _ ->
        changeset =
          BestLapTime.changeset(%BestLapTime{}, attrs)
          |> Ecto.Changeset.add_error(:date, "Best lap time for the day already exists")

        {:error, changeset}
    end
  end

  defp get_best_lap_time_for_a_day(date, motorcycle_id, user_track_id) do
    [y, m, d] = String.split(date, "-") |> Enum.map(&String.to_integer/1)
    {:ok, date} = Date.new(y, m, d)

    BestLapTime
    |> where([blt], blt.motorcycle_id == ^motorcycle_id and blt.user_track_id == ^user_track_id)
    |> where([blt], blt.date == ^date)
    |> Repo.one()
    |> IO.inspect()
  end
end
