defmodule Bauble.Schema do
  @moduledoc """
  The Schema module
  """

  defmacro __using__(_) do
    # Adds some basic UUID stuff to the ecto schema
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @derive {Phoenix.Param, key: :id}
      @timestamps_opts type: :utc_datetime_usec
    end
  end
end
