defmodule Bauble.Factory do
  use ExMachina.Ecto, repo: Bauble.Repo

  alias Bauble.Accounts.User
end
