defmodule Bauble.Repo.Migrations.CreateDeckTypes do
  use Ecto.Migration

  def change do
    create table(:deck_types) do
      add :name, :string
      add :active, :boolean, default: true, null: false
      add :superceded_by_deck_type_id, references(:deck_types, on_delete: :nothing)

      timestamps()
    end
  end
end
