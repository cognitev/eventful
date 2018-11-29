defmodule Eventful.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :webhook, :string
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:subscriptions, [:topic_id])
  end
end
