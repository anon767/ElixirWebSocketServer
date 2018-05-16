# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :binary_data_over_phoenix_socket, BinaryDataOverPhoenixSocket.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q3ATIefW30t/q79WqZxcKwJG83HYQkQTpx85Rg6owYawtn0mHHJsT3v/xgwZSAqr",
  render_errors: [view: BinaryDataOverPhoenixSocket.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BinaryDataOverPhoenixSocket.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
