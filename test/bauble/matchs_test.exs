defmodule Bauble.MatchsTest do
  use Bauble.DataCase

  alias Bauble.Matchs

  describe "matches" do
    alias Bauble.Matchs.Match

    import Bauble.MatchsFixtures

    @invalid_attrs %{date: nil, die_roll: nil, event: nil, formats: nil, round: nil, type: nil}

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Matchs.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Matchs.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      valid_attrs = %{date: ~D[2022-04-06], die_roll: true, event: :local, formats: :standard, round: 42, type: :modo}

      assert {:ok, %Match{} = match} = Matchs.create_match(valid_attrs)
      assert match.date == ~D[2022-04-06]
      assert match.die_roll == true
      assert match.event == :local
      assert match.formats == :standard
      assert match.round == 42
      assert match.type == :modo
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Matchs.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      update_attrs = %{date: ~D[2022-04-07], die_roll: false, event: :league, formats: :modern, round: 43, type: :paper}

      assert {:ok, %Match{} = match} = Matchs.update_match(match, update_attrs)
      assert match.date == ~D[2022-04-07]
      assert match.die_roll == false
      assert match.event == :league
      assert match.formats == :modern
      assert match.round == 43
      assert match.type == :paper
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Matchs.update_match(match, @invalid_attrs)
      assert match == Matchs.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Matchs.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Matchs.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Matchs.change_match(match)
    end
  end
end
