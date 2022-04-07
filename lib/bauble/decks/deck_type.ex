defmodule Bauble.Decks.DeckType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deck_type" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(deck_type, attrs) do
    deck_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
