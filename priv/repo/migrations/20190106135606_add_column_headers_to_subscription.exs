defmodule Eventful.Repo.Migrations.AddColumnHeadersToSubscription do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :headers, :text
    end
  end
end
