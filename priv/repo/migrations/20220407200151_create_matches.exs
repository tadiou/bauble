defmodule Bauble.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :date, :date
      add :round, :integer
      add :die_roll, :boolean, default: false, null: false
      add :opponent_id, references(:users, on_delete: :nothing)
      add :player_id, references(:users, on_delete: :nothing)
      add :deck_list_id, references(:deck_lists, on_delete: :nothing)
      add :opponent_deck_type, references(:deck_types, on_delete: :nothing)

      timestamps()
    end

    create index(:matches, [:opponent_id])
    create index(:matches, [:player_id])
    create index(:matches, [:deck_list_id])
    create index(:matches, [:opponent_deck_type])
  end
end
