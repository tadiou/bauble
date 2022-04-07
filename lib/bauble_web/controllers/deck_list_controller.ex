defmodule BaubleWeb.DeckListController do
  use BaubleWeb, :controller

  alias Bauble.Decks
  alias Bauble.Decks.DeckList

  def index(conn, _params) do
    deck_lists = Decks.list_deck_lists()
    render(conn, "index.html", deck_lists: deck_lists)
  end

  def new(conn, _params) do
    changeset = Decks.change_deck_list(%DeckList{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deck_list" => deck_list_params}) do
    case Decks.create_deck_list(deck_list_params) do
      {:ok, deck_list} ->
        conn
        |> put_flash(:info, "Deck list created successfully.")
        |> redirect(to: Routes.deck_list_path(conn, :show, deck_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deck_list = Decks.get_deck_list!(id)
    render(conn, "show.html", deck_list: deck_list)
  end

  def edit(conn, %{"id" => id}) do
    deck_list = Decks.get_deck_list!(id)
    changeset = Decks.change_deck_list(deck_list)
    render(conn, "edit.html", deck_list: deck_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deck_list" => deck_list_params}) do
    deck_list = Decks.get_deck_list!(id)

    case Decks.update_deck_list(deck_list, deck_list_params) do
      {:ok, deck_list} ->
        conn
        |> put_flash(:info, "Deck list updated successfully.")
        |> redirect(to: Routes.deck_list_path(conn, :show, deck_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deck_list: deck_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck_list = Decks.get_deck_list!(id)
    {:ok, _deck_list} = Decks.delete_deck_list(deck_list)

    conn
    |> put_flash(:info, "Deck list deleted successfully.")
    |> redirect(to: Routes.deck_list_path(conn, :index))
  end
end
