defmodule Tracker.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext", "")

    create table(:makes) do
      add(:name, :citext, null: false)
      timestamps()
    end

    create(unique_index(:makes, [:name]))

    create table(:modals) do
      add(:name, :citext, null: false)
      add(:make_id, references(:makes, on_delete: :delete_all), null: false)
      timestamps()
    end

    create(index(:modals, [:make_id]))
    create(unique_index(:modals, [:name, :make_id]))
  end
end
