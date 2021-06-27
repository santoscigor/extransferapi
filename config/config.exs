# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :extransferapi,
  ecto_repos: [Extransferapi.Repo]

config :extransferapi, Extransferapi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :extransferapi, ExtransferapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+uiToa14rz460YtAnKK1Px2AKNH04kEyfh7cbO3oxV5SiYhZUN1RlCgYaRBw3aT1",
  render_errors: [view: ExtransferapiWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Extransferapi.PubSub
  #pubsub: [name: Extransferapi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
