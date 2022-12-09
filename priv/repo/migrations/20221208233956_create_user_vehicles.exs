defmodule Tracker.Repo.Migrations.CreateUserVehicles do
  use Ecto.Migration

  def change do
    create table(:user_vehicles) do
      add(:year, :integer, null: false)
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
      add(:make_id, references(:makes, on_delete: :delete_all), null: false)
      add(:modal_id, references(:modals, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:user_vehicles, [:user_id]))
    create(unique_index(:user_vehicles, [:user_id, :modal_id, :year, :make_id]))
  end
end
