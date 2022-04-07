defmodule Bauble.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :location, :string
      add :active, :boolean, default: false, null: false
      add :mtgo_handle, :string
      add :mtga_handle, :string

      timestamps()
    end

    create unique_index(:users, :mtgo_handle)
    create unique_index(:users, :mtga_handle)
  end
end
