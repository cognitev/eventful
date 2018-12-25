use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :eventful, EventfulWeb.Endpoint,
  secret_key_base: System.get_env("secret_key_base")

# Configure your database
config :eventful, Eventful.Repo,
  username: System.get_env("DB_USERNAME") || "root",
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME") || "eventful",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool_size: 15
