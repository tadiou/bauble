defmodule Bauble.Matchs.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :date, :date
    field :die_roll, :boolean, default: false
    field :event, Ecto.Enum, values: [:local, :league, :challenge, :headsup, :"1k", :"2k", :"5k", :"20k", :scg_main, :scg_side, :gp_main, :gp_side, :ee_main, :ew_main, :showcase, :ptq, :mocs, :preliminaries, :pt]
    field :formats, Ecto.Enum, values: [:standard, :modern, :pioneer, :historic, :alchemy, :pauper, :legacy, :vintage, :penny, :commander, :multi_commander, :historic_brawl, :brawl]
    field :round, :integer
    field :type, Ecto.Enum, values: [:modo, :paper, :mtga]
    field :opponent_id, :id
    field :player_id, :id
    field :deck_list_id, :id
    field :opponent_deck_type, :id

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:date, :round, :die_roll, :type, :event, :formats])
    |> validate_required([:date, :round, :die_roll, :type, :event, :formats])
  end
end
