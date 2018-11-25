defmodule Eventful.Repo do
  use Ecto.Repo,
    otp_app: :eventful,
    adapter: Ecto.Adapters.MySQL
end
