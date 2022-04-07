defmodule BaubleWeb.DeckTypeControllerTest do
  use BaubleWeb.ConnCase

  import Bauble.DecksFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all deck_type", %{conn: conn} do
      conn = get(conn, Routes.deck_type_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Deck type"
    end
  end

  describe "new deck_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.deck_type_path(conn, :new))
      assert html_response(conn, 200) =~ "New Deck type"
    end
  end

  describe "create deck_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.deck_type_path(conn, :create), deck_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.deck_type_path(conn, :show, id)

      conn = get(conn, Routes.deck_type_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Deck type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.deck_type_path(conn, :create), deck_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Deck type"
    end
  end

  describe "edit deck_type" do
    setup [:create_deck_type]

    test "renders form for editing chosen deck_type", %{conn: conn, deck_type: deck_type} do
      conn = get(conn, Routes.deck_type_path(conn, :edit, deck_type))
      assert html_response(conn, 200) =~ "Edit Deck type"
    end
  end

  describe "update deck_type" do
    setup [:create_deck_type]

    test "redirects when data is valid", %{conn: conn, deck_type: deck_type} do
      conn = put(conn, Routes.deck_type_path(conn, :update, deck_type), deck_type: @update_attrs)
      assert redirected_to(conn) == Routes.deck_type_path(conn, :show, deck_type)

      conn = get(conn, Routes.deck_type_path(conn, :show, deck_type))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, deck_type: deck_type} do
      conn = put(conn, Routes.deck_type_path(conn, :update, deck_type), deck_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Deck type"
    end
  end

  describe "delete deck_type" do
    setup [:create_deck_type]

    test "deletes chosen deck_type", %{conn: conn, deck_type: deck_type} do
      conn = delete(conn, Routes.deck_type_path(conn, :delete, deck_type))
      assert redirected_to(conn) == Routes.deck_type_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.deck_type_path(conn, :show, deck_type))
      end
    end
  end

  defp create_deck_type(_) do
    deck_type = deck_type_fixture()
    %{deck_type: deck_type}
  end
end
