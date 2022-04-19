defmodule Bauble.Decks.DeckList do
  use Bauble.Schema
  import Ecto.Changeset

  alias Bauble.Accounts.User

  schema "deck_lists" do
    field :list, :string
    field :name, :string
    field :version, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(deck_list, attrs) do
    deck_list
    |> cast(attrs, [:name, :version, :list, :user_id])
    |> validate_required([:name, :version, :list, :user_id])
  end
end
