defmodule Bauble.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bauble.Decks` context.
  """

  @doc """
  Generate a deck_list.
  """
  def deck_list_fixture(attrs \\ %{}) do
    {:ok, deck_list} =
      attrs
      |> Enum.into(%{
        list: "some list",
        name: "some name",
        version: "some version"
      })
      |> Bauble.Decks.create_deck_list()

    deck_list
  end

  @doc """
  Generate a deck_type.
  """
  def deck_type_fixture(attrs \\ %{}) do
    {:ok, deck_type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Bauble.Decks.create_deck_type()

    deck_type
  end
end
