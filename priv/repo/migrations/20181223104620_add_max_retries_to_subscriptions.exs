defmodule Eventful.Repo.Migrations.AddMaxRetriesToSubscriptions do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :max_retries, :integer, default: nil
    end
  end
end
