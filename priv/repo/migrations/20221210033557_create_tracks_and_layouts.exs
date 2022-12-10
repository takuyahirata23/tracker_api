defmodule Tracker.Repo.Migrations.CreateTracksAndLayouts do
  use Ecto.Migration

  def change do
    create table(:tracks, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, size: 50, null: false)
      add(:description, :string, size: 200)
      add(:length, :float, null: false)
      add(:latitude, :float, null: false)
      add(:longitude, :float, null: false)

      timestamps()
    end

    create(unique_index(:tracks, [:name]))
  end
end
