defmodule Eventful.Repo.Migrations.CreateEventLogs do
  use Ecto.Migration

  def change do
    create table(:event_logs) do
      add :status, :string
      add :subscription_id, references(:subscriptions, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:event_logs, [:subscription_id])
    create index(:event_logs, [:event_id])
  end
end
