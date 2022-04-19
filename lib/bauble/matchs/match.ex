defmodule Bauble.Matchs.Match do
  use Bauble.Schema
  import Ecto.Changeset
  alias Bauble.Account.User

  @event_values [
    :local,
    :league,
    :challenge,
    :headsup,
    :"1k",
    :"2k",
    :"5k",
    :"20k",
    :scg_main,
    :scg_side,
    :gp_main,
    :gp_side,
    :ee_main,
    :ew_main,
    :showcase,
    :ptq,
    :mocs,
    :preliminaries,
    :pt
  ]
  @format_values [
    :standard,
    :modern,
    :pioneer,
    :historic,
    :alchemy,
    :pauper,
    :legacy,
    :vintage,
    :penny,
    :commander,
    :multi_commander,
    :historic_brawl,
    :brawl
  ]

  @required_attributes [
    :date,
    :round,
    :die_roll,
    :type,
    :event,
    :formats,
    :deck_list_id,
    :opponent_deck_type_id,
    :player_id,
    :opponent_id
  ]

  @optional_attributes []

  schema "matches" do
    field :date, :date
    field :die_roll, :boolean, default: false

    field :event, Ecto.Enum, values: @event_values

    field :formats, Ecto.Enum, values: @format_values

    field :round, :integer
    field :type, Ecto.Enum, values: [:modo, :paper, :mtga]

    belongs_to :deck_list, Bauble.Decks.DeckList
    belongs_to :opponent_deck_type, Bauble.Decks.DeckType
    belongs_to :player, User
    belongs_to :opponent, User

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, @required_attributes)
    |> validate_required(@required_attributes ++ @optional_attributes)
  end
end
