defmodule Eventful.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :sender_info, :text
      add :payload, :text
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:topic_id])
  end
end
