defmodule Bauble.Repo.Migrations.CreateDeckLists do
  use Ecto.Migration

  def change do
    create table(:deck_lists) do
      add :name, :string
      add :version, :string
      add :list, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:deck_lists, [:user_id])
  end
end
