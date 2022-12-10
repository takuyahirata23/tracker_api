defmodule Tracker.Repo.Migrations.CreateMotorcycles do
  use Ecto.Migration

  def change do
    create table(:motorcycles, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:year, :integer, null: false)
      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false)
      add(:make_id, references(:makes, type: :binary_id, on_delete: :delete_all), null: false)
      add(:modal_id, references(:modals, type: :binary_id, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:motorcycles, [:user_id]))
    create(unique_index(:motorcycles, [:user_id, :modal_id, :year, :make_id]))
  end
end
