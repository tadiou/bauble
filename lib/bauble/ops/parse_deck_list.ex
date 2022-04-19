defmodule Ops.ParseDeckList do
  @moduledoc """
  There's a pretty standard format for the way deck lists are shared and parsed
  and that is one card per line with the quantity beforehand

  e.g.
  1 Swamp

  This is a newline delimited format, so that it's easy to copy and paste from
  the current existing formatters (Arena, MTGO, Goldfish, etc.)

  This could handle Companions better as it's own individual type, but that
  is probably more validation of the game rules engine than anything else.

  For sample formatted lists that would be parsed from the front end, see
  `test/bauble/ops/valid_deck_lists` and `test/bauble/ops/invalid_deck_lists`.
  """

  defmodule InvalidQuantityError do
    defexception message: ""
  end

  @type maindeck :: [{integer, String.t()}]
  @type sideboard :: [{integer, String.t()}]

  @doc """
  Public interface for Ops.ParseDeckLIst.

  Reads the blob, converts it into an array of tuples, and then validates it
  """
  @spec run(content :: String.t()) :: {:ok, {maindeck, sideboard}} | {:error, String.t()}
  def run(content) do
    newline_deliniated_deck_list = content |> split_lines

    {maindeck, sideboard} =
      newline_deliniated_deck_list
      |> cleanup_deck_list

    try do
      {:ok, validate({maindeck, sideboard})}
    rescue
      e in InvalidQuantityError -> {:error, e.message}
    end
  end

  # Remove any preceding newlines so that we know the next newline should separate the maindeck
  # from the sideboard.
  defp split_lines(string) do
    string |> String.split("\n") |> Enum.drop_while(&empty_line/1)
  end

  defp cleanup_deck_list(ary) do
    result =
      Enum.map(ary, fn line ->
        maybe_delete_line(line)
      end)
      |> Enum.filter(& &1)

    split_sideboard(result)
  end

  defp split_sideboard(deck_list) do
    {_, separator_index} =
      deck_list |> Enum.with_index(0) |> Enum.filter(fn {line, _index} -> line == "" end) |> hd()

    {maindeck, sideboard} = Enum.split(deck_list, separator_index)

    {maindeck |> format_cards, sideboard |> Enum.reject(&empty_line/1) |> format_cards}
  end

  # Main validation pathway
  defp validate({maindeck, sideboard}) do
    maindeck_list = Enum.map(maindeck, &Tuple.to_list/1)
    sideboard_list = Enum.map(sideboard, &Tuple.to_list/1)

    validate(maindeck_list ++ sideboard_list, :total_list)

    {maindeck |> validate(:maindeck), sideboard |> validate(:sideboard)}
  end

  defp validate(deck_list, :maindeck) do
    maindeck_card_count = Enum.map(deck_list, fn {_, quantity} -> quantity end) |> Enum.sum()

    if maindeck_card_count < 60 do
      raise(InvalidQuantityError,
        message: "Main deck requires at least 60 cards, has #{maindeck_card_count}"
      )
    end
  end

  defp validate(deck_list, :sideboard) do
    sideboard_card_count = Enum.map(deck_list, fn {_, quantity} -> quantity end) |> Enum.sum()

    if sideboard_card_count != 15 && sideboard_card_count != 0 do
      raise(InvalidQuantityError,
        message: "Sideboard requires exactly 15 or 0 cards, has #{sideboard_card_count}"
      )
    end
  end

  # This is possible to use a `validate/3` to loop over here, but `map_reduce` felt a little cleaner
  # We don't care about the result, but we do care about iterating through the total deck_list
  # to determine if there's a quantity of more that 4
  #
  # There's exactly 5 cards that allow you to have more than 4 cards in a deck, Dragon's Approach,
  # Persistent Petitioners, Rat Colony, Relentless Rats, Shadowborn Apostle. If I was going to
  # handle that edge case, I'd probably handle that differently, but out of 50k-ish cards, and
  # the fact that the demographic for the product wouldn't ever use them, I'm not gonna make a
  # special case. If so, I'd just expand `is_basic_land`, into `allowed_more_than_4_of`.
  defp validate(deck_list, :total_list) do
    Enum.map_reduce(deck_list, %{}, fn [name, quantity], acc_list ->
      case Map.get(acc_list, name) do
        nil ->
          if quantity > 4 && !is_basic_land(name) do
            raise(InvalidQuantityError,
              message: "#{quantity} cards for #{name} when only 4 allowed"
            )
          end

          {nil, Map.put(acc_list, name, quantity)}

        acc_val ->
          if acc_val + quantity > 4 && !is_basic_land(name) do
            raise(InvalidQuantityError,
              message: "#{quantity} cards for #{name} when only 4 allowed"
            )
          end

          {nil, Map.put(acc_list, name, acc_val + quantity)}
      end
    end)
  end

  # Converts cards into a tuple list
  defp format_cards(deck_list) do
    Enum.map(deck_list, fn line ->
      [quantity, name] = String.split(line, " ", parts: 2)
      {name, quantity |> String.to_integer()}
    end)
  end

  # There's a few reasons to straight up delete a line so they don't add to the list
  defp maybe_delete_line(string) do
    cond do
      is_keyworded(string) ->
        nil

      true ->
        string
    end
  end

  defp is_basic_land(card_name) do
    basic_lands = ~w(plains swamp island mountain forest)
    Enum.member?(basic_lands, card_name |> String.downcase())
  end

  # This could ultimately be translated too
  defp is_keyworded(string) do
    keywords = ~w(maindeck deck sideboard main)
    Enum.member?(keywords, string |> String.downcase())
  end

  defp empty_line(line), do: line == ""
end
