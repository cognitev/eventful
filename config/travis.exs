use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :eventful, EventfulWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :eventful, Eventful.Repo,
  username: System.get_env("DB_USERNAME") || "root",
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME") || "eventful_test",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
