defmodule Bauble.Decks.DeckList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deck_lists" do
    field :list, :string
    field :name, :string
    field :version, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(deck_list, attrs) do
    deck_list
    |> cast(attrs, [:name, :version, :list])
    |> validate_required([:name, :version, :list])
  end
end
