defmodule Bauble.Repo.Migrations.CreateDeckLists do
  use Ecto.Migration

  def change do
    create table(:deck_lists) do
      add :name, :string, null: false
      add :version, :string, null: false
      add :list, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :metadata, {:array, :map}, default: [], null: false

      timestamps()
    end

    create index(:deck_lists, [:user_id])
  end
end
