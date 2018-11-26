use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :eventful, EventfulWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :eventful, Eventful.Repo,
  username: "root",
  password: System.get_env("DB_PASSWORD"),
  database: "eventful_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
