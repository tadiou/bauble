defmodule BaubleWeb.DeckTypeController do
  use BaubleWeb, :controller

  alias Bauble.Decks
  alias Bauble.Decks.DeckType

  def index(conn, _params) do
    deck_type = Decks.list_deck_type()
    render(conn, "index.html", deck_type: deck_type)
  end

  def new(conn, _params) do
    changeset = Decks.change_deck_type(%DeckType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deck_type" => deck_type_params}) do
    case Decks.create_deck_type(deck_type_params) do
      {:ok, deck_type} ->
        conn
        |> put_flash(:info, "Deck type created successfully.")
        |> redirect(to: Routes.deck_type_path(conn, :show, deck_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deck_type = Decks.get_deck_type!(id)
    render(conn, "show.html", deck_type: deck_type)
  end

  def edit(conn, %{"id" => id}) do
    deck_type = Decks.get_deck_type!(id)
    changeset = Decks.change_deck_type(deck_type)
    render(conn, "edit.html", deck_type: deck_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deck_type" => deck_type_params}) do
    deck_type = Decks.get_deck_type!(id)

    case Decks.update_deck_type(deck_type, deck_type_params) do
      {:ok, deck_type} ->
        conn
        |> put_flash(:info, "Deck type updated successfully.")
        |> redirect(to: Routes.deck_type_path(conn, :show, deck_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deck_type: deck_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck_type = Decks.get_deck_type!(id)
    {:ok, _deck_type} = Decks.delete_deck_type(deck_type)

    conn
    |> put_flash(:info, "Deck type deleted successfully.")
    |> redirect(to: Routes.deck_type_path(conn, :index))
  end
end
