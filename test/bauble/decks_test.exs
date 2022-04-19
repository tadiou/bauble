defmodule Bauble.DecksTest do
  use Bauble.DataCase

  alias Bauble.Decks

  describe "deck_lists" do
    alias Bauble.Decks.DeckList

    import Bauble.DecksFixtures

    @invalid_attrs %{list: nil, name: nil, version: nil}

    test "list_deck_lists/0 returns all deck_lists" do
      deck_list = deck_list_fixture()
      assert Decks.list_deck_lists() == [deck_list]
    end

    test "get_deck_list!/1 returns the deck_list with given id" do
      deck_list = deck_list_fixture()
      assert Decks.get_deck_list!(deck_list.id) == deck_list
    end

    test "create_deck_list/1 with valid data creates a deck_list" do
      valid_attrs = %{list: "some list", name: "some name", version: "some version"}
      p
      assert {:ok, %DeckList{} = deck_list} = Decks.create_deck_list(valid_attrs)
      assert deck_list.list == "some list"
      assert deck_list.name == "some name"
      assert deck_list.version == "some version"
    end

    test "create_deck_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck_list(@invalid_attrs)
    end

    test "update_deck_list/2 with valid data updates the deck_list" do
      deck_list = deck_list_fixture()

      update_attrs = %{
        list: "some updated list",
        name: "some updated name",
        version: "some updated version"
      }

      assert {:ok, %DeckList{} = deck_list} = Decks.update_deck_list(deck_list, update_attrs)
      assert deck_list.list == "some updated list"
      assert deck_list.name == "some updated name"
      assert deck_list.version == "some updated version"
    end

    test "update_deck_list/2 with invalid data returns error changeset" do
      deck_list = deck_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck_list(deck_list, @invalid_attrs)
      assert deck_list == Decks.get_deck_list!(deck_list.id)
    end

    test "delete_deck_list/1 deletes the deck_list" do
      deck_list = deck_list_fixture()
      assert {:ok, %DeckList{}} = Decks.delete_deck_list(deck_list)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck_list!(deck_list.id) end
    end

    test "change_deck_list/1 returns a deck_list changeset" do
      deck_list = deck_list_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck_list(deck_list)
    end
  end

  describe "deck_type" do
    alias Bauble.Decks.DeckType

    import Bauble.DecksFixtures

    @invalid_attrs %{name: nil}

    test "list_deck_type/0 returns all deck_type" do
      deck_type = deck_type_fixture()
      assert Decks.list_deck_type() == [deck_type]
    end

    test "get_deck_type!/1 returns the deck_type with given id" do
      deck_type = deck_type_fixture()
      assert Decks.get_deck_type!(deck_type.id) == deck_type
    end

    test "create_deck_type/1 with valid data creates a deck_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %DeckType{} = deck_type} = Decks.create_deck_type(valid_attrs)
      assert deck_type.name == "some name"
    end

    test "create_deck_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck_type(@invalid_attrs)
    end

    test "update_deck_type/2 with valid data updates the deck_type" do
      deck_type = deck_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %DeckType{} = deck_type} = Decks.update_deck_type(deck_type, update_attrs)
      assert deck_type.name == "some updated name"
    end

    test "update_deck_type/2 with invalid data returns error changeset" do
      deck_type = deck_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Decks.update_deck_type(deck_type, @invalid_attrs)
      assert deck_type == Decks.get_deck_type!(deck_type.id)
    end

    test "delete_deck_type/1 deletes the deck_type" do
      deck_type = deck_type_fixture()
      assert {:ok, %DeckType{}} = Decks.delete_deck_type(deck_type)
      assert_raise Ecto.NoResultsError, fn -> Decks.get_deck_type!(deck_type.id) end
    end

    test "change_deck_type/1 returns a deck_type changeset" do
      deck_type = deck_type_fixture()
      assert %Ecto.Changeset{} = Decks.change_deck_type(deck_type)
    end
  end
end
