defmodule Bauble.Decks do
  @moduledoc """
  The Decks context.
  """

  import Ecto.Query, warn: false
  alias Bauble.Repo

  alias Bauble.Decks.DeckList

  @doc """
  Returns the list of deck_lists.

  ## Examples

      iex> list_deck_lists()
      [%DeckList{}, ...]

  """
  def list_deck_lists do
    Repo.all(DeckList)
  end

  @doc """
  Gets a single deck_list.

  Raises `Ecto.NoResultsError` if the Deck list does not exist.

  ## Examples

      iex> get_deck_list!(123)
      %DeckList{}

      iex> get_deck_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck_list!(id), do: Repo.get!(DeckList, id)

  @doc """
  Creates a deck_list.

  ## Examples

      iex> create_deck_list(%{field: value})
      {:ok, %DeckList{}}

      iex> create_deck_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck_list(attrs \\ %{}) do
    %DeckList{}
    |> DeckList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deck_list.

  ## Examples

      iex> update_deck_list(deck_list, %{field: new_value})
      {:ok, %DeckList{}}

      iex> update_deck_list(deck_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck_list(%DeckList{} = deck_list, attrs) do
    deck_list
    |> DeckList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck_list.

  ## Examples

      iex> delete_deck_list(deck_list)
      {:ok, %DeckList{}}

      iex> delete_deck_list(deck_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck_list(%DeckList{} = deck_list) do
    Repo.delete(deck_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck_list changes.

  ## Examples

      iex> change_deck_list(deck_list)
      %Ecto.Changeset{data: %DeckList{}}

  """
  def change_deck_list(%DeckList{} = deck_list, attrs \\ %{}) do
    DeckList.changeset(deck_list, attrs)
  end

  alias Bauble.Decks.DeckType

  @doc """
  Returns the list of deck_type.

  ## Examples

      iex> list_deck_type()
      [%DeckType{}, ...]

  """
  def list_deck_type do
    Repo.all(DeckType)
  end

  @doc """
  Gets a single deck_type.

  Raises `Ecto.NoResultsError` if the Deck type does not exist.

  ## Examples

      iex> get_deck_type!(123)
      %DeckType{}

      iex> get_deck_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck_type!(id), do: Repo.get!(DeckType, id)

  @doc """
  Creates a deck_type.

  ## Examples

      iex> create_deck_type(%{field: value})
      {:ok, %DeckType{}}

      iex> create_deck_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck_type(attrs \\ %{}) do
    %DeckType{}
    |> DeckType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deck_type.

  ## Examples

      iex> update_deck_type(deck_type, %{field: new_value})
      {:ok, %DeckType{}}

      iex> update_deck_type(deck_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck_type(%DeckType{} = deck_type, attrs) do
    deck_type
    |> DeckType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck_type.

  ## Examples

      iex> delete_deck_type(deck_type)
      {:ok, %DeckType{}}

      iex> delete_deck_type(deck_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck_type(%DeckType{} = deck_type) do
    Repo.delete(deck_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck_type changes.

  ## Examples

      iex> change_deck_type(deck_type)
      %Ecto.Changeset{data: %DeckType{}}

  """
  def change_deck_type(%DeckType{} = deck_type, attrs \\ %{}) do
    DeckType.changeset(deck_type, attrs)
  end
end
