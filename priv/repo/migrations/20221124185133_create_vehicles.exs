defmodule Tracker.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:makes, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :citext, null: false)
      timestamps()
    end

    create(unique_index(:makes, [:name]))

    create table(:modals, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :citext, null: false)
      add(:make_id, references(:makes, type: :binary_id, on_delete: :delete_all), null: false)
      timestamps()
    end

    create(index(:modals, [:make_id]))
    create(unique_index(:modals, [:name, :make_id]))
  end
end
