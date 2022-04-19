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
      deck_list_valid_attributes(attrs)
      |> Bauble.Decks.create_deck_list()

    deck_list
  end

  def deck_list_valid_attributes(attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      list: "some list",
      name: "some name",
      version: "some version",
      user_id: attrs[:user_id] || UUID.uuid4()
    })
  end

  @doc """
  Generate a deck_type.
  """
  def deck_type_fixture(attrs \\ %{}) do
    {:ok, deck_type} =
      attrs
      |> Enum.into(%{
        name: "some name",
        active: true,
        superceded_by_deck_type: nil
      })
      |> Bauble.Decks.create_deck_type()

    deck_type
  end
end
