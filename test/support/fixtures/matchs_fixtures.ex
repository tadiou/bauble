defmodule Bauble.MatchsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bauble.Matchs` context.
  """

  @doc """
  Generate a match.
  """
  def match_fixture(attrs \\ %{}) do
    {:ok, match} =
      attrs
      |> Enum.into(%{
        date: ~D[2022-04-06],
        die_roll: true,
        event: :local,
        formats: :standard,
        round: 42,
        type: :modo
      })
      |> Bauble.Matchs.create_match()

    match
  end
end
