defmodule Bauble.Decks.DeckType do
  use Bauble.Schema
  import Ecto.Changeset

  schema "deck_type" do
    field :name, :string, null: false
    field :active, :boolean, default: true, null: false
    field :superceded_by_deck_type_id, :id

    timestamps()
  end

  @doc false
  def changeset(deck_type, attrs) do
    deck_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
