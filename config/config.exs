# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :eventful,
  ecto_repos: [Eventful.Repo]

# Configures the endpoint
config :eventful, EventfulWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vdy718QGS/9kk9Sgtl55rhQxx+B8mcTMC8L391Q7O+r4wjaIaSa0ziyj48IETyqh",
  render_errors: [view: EventfulWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eventful.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
