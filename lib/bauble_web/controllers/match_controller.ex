defmodule BaubleWeb.MatchController do
  use BaubleWeb, :controller

  alias Bauble.Matchs
  alias Bauble.Matchs.Match

  def index(conn, _params) do
    matches = Matchs.list_matches()
    render(conn, "index.html", matches: matches)
  end

  def new(conn, _params) do
    changeset = Matchs.change_match(%Match{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"match" => match_params}) do
    case Matchs.create_match(match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: Routes.match_path(conn, :show, match))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Matchs.get_match!(id)
    render(conn, "show.html", match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Matchs.get_match!(id)
    changeset = Matchs.change_match(match)
    render(conn, "edit.html", match: match, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Matchs.get_match!(id)

    case Matchs.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: Routes.match_path(conn, :show, match))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", match: match, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Matchs.get_match!(id)
    {:ok, _match} = Matchs.delete_match(match)

    conn
    |> put_flash(:info, "Match deleted successfully.")
    |> redirect(to: Routes.match_path(conn, :index))
  end
end
