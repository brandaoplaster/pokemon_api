# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pokemon_api,
  ecto_repos: [PokemonApi.Repo]

# Configures the endpoint
config :pokemon_api, PokemonApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iwGI9tOzxYDuYdytHXWuJSKUUARHcRV26iPOBxpGbQFuSTBMS3hzSRgPg3U5XjJJ",
  render_errors: [view: PokemonApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PokemonApi.PubSub,
  live_view: [signing_salt: "9qLHk4Ap"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :pokemon_api, PokemonApiWeb.Auth.Guardian,
       issuer: "pokemon_api",
       secret_key: "M/jC/+Gk6yJGtadGCQrhcbzYu1EpXY5gdjKRzTIqtbgGK9PS/r0wGn4JvTicK3DI"

config :pokemon_api, PokemonApiWeb.Auth.Pipiline,
  module: PokemonApiWeb.Auth.Guardian,
  error_handler: PokemonApiWeb.Auth.ErrorHandler
