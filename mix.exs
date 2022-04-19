defmodule Bauble.MixProject do
  use Mix.Project

  def project do
    [
      app: :bauble,
      version: "0.0.1",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Bauble.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.17.5"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev},

      # Database
      {:postgrex, ">= 0.0.0"},
      {:ecto_enum_migration, "~> 0.3"},
      {:ecto_sql, "~> 3.6"},
      {:uuid, "~> 1.1"},
      {:triplex, "~> 1.3"},

      # Auth
      {:bodyguard, "~> 2.4"},
      {:bcrypt_elixir, "~> 2.0"},

      # Math
      {:math, "~> 0.7.0"},
      {:statistics, "~> 0.6.2"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:plug_cowboy, "~> 2.5"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},

      ###################
      # Dev Tools       #
      ###################

      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.30.0", only: :test},

      ##################
      # Testing        #
      ##################

      # Sample Data & Factories
      {:assertions, "~> 0.18.1", only: :test},
      # {:ex_machina, "~> 2.7"},
      {:faker, "~> 0.16"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end
end
