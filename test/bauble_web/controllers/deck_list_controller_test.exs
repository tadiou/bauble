defmodule BaubleWeb.DeckListControllerTest do
  use BaubleWeb.ConnCase

  import Bauble.DecksFixtures

  @create_attrs %{list: "some list", name: "some name", version: "some version"}
  @update_attrs %{list: "some updated list", name: "some updated name", version: "some updated version"}
  @invalid_attrs %{list: nil, name: nil, version: nil}

  describe "index" do
    test "lists all deck_lists", %{conn: conn} do
      conn = get(conn, Routes.deck_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Deck lists"
    end
  end

  describe "new deck_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.deck_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New Deck list"
    end
  end

  describe "create deck_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.deck_list_path(conn, :create), deck_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.deck_list_path(conn, :show, id)

      conn = get(conn, Routes.deck_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Deck list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.deck_list_path(conn, :create), deck_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Deck list"
    end
  end

  describe "edit deck_list" do
    setup [:create_deck_list]

    test "renders form for editing chosen deck_list", %{conn: conn, deck_list: deck_list} do
      conn = get(conn, Routes.deck_list_path(conn, :edit, deck_list))
      assert html_response(conn, 200) =~ "Edit Deck list"
    end
  end

  describe "update deck_list" do
    setup [:create_deck_list]

    test "redirects when data is valid", %{conn: conn, deck_list: deck_list} do
      conn = put(conn, Routes.deck_list_path(conn, :update, deck_list), deck_list: @update_attrs)
      assert redirected_to(conn) == Routes.deck_list_path(conn, :show, deck_list)

      conn = get(conn, Routes.deck_list_path(conn, :show, deck_list))
      assert html_response(conn, 200) =~ "some updated list"
    end

    test "renders errors when data is invalid", %{conn: conn, deck_list: deck_list} do
      conn = put(conn, Routes.deck_list_path(conn, :update, deck_list), deck_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Deck list"
    end
  end

  describe "delete deck_list" do
    setup [:create_deck_list]

    test "deletes chosen deck_list", %{conn: conn, deck_list: deck_list} do
      conn = delete(conn, Routes.deck_list_path(conn, :delete, deck_list))
      assert redirected_to(conn) == Routes.deck_list_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.deck_list_path(conn, :show, deck_list))
      end
    end
  end

  defp create_deck_list(_) do
    deck_list = deck_list_fixture()
    %{deck_list: deck_list}
  end
end
