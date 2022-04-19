defmodule Ops.ParseDeckListTest do
  use ExUnit.Case, async: true

  alias Ops.ParseDeckList

  describe "valid lists" do
    valid_list_paths = Path.wildcard("test/bauble/ops/valid_deck_lists/*.txt")

    for valid_list_path <- valid_list_paths do
      test "#{valid_list_path} parses" do
        {:ok, content} = read_file(unquote(valid_list_path))

        {:ok, _result} = ParseDeckList.run(content)
      end
    end
  end

  describe "invalid lists" do
    invalid_list_paths = Path.wildcard("test/bauble/ops/invalid_deck_lists/*.txt")

    for invalid_list_path <- invalid_list_paths do
      test "#{invalid_list_path} parses" do
        {:ok, content} = read_file(unquote(invalid_list_path))

        {:error, _result} = ParseDeckList.run(content)
      end
    end
  end

  defp read_file(file) do
    File.read(file)
  end
end
