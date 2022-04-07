defmodule Bauble.Repo.Migrations.CreateDeckType do
  use Ecto.Migration

  def change do
    create table(:deck_type) do
      add :name, :string

      timestamps()
    end
  end
end
