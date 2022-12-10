defmodule Tracker.Repo.Migrations.CreateMyTracksAndBestLap do
  use Ecto.Migration

  def change do
    create table(:user_tracks, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false)
      add(:track_id, references(:tracks, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:user_tracks, [:user_id]))
    create(unique_index(:user_tracks, [:user_id, :track_id]))

    create table(:best_lap_times, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:minute, :integer, default: 0)
      add(:seconds, :integer, null: false)
      add(:miliseconds, :integer, default: 0)
      add(:date, :utc_datetime, null: false)

      add(:motorcycle_id, references(:motorcycles, type: :binary_id, on_delete: :delete_all),
        null: false
      )

      add(:user_track_id, references(:user_tracks, type: :binary_id, on_delete: :delete_all),
        null: false
      )

      timestamps()
    end

    create(index(:best_lap_times, [:user_track_id]))
  end
end
