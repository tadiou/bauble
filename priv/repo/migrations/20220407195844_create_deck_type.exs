defmodule Bauble.Repo.Migrations.CreateDeckTypes do
  use Ecto.Migration

  def change do
    create table(:deck_types) do
      add :name, :string

      timestamps()
    end
  end
end
