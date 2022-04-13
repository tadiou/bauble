{:ok, _} = Application.ensure_all_started(:bauble)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Bauble.Repo, :manual)
