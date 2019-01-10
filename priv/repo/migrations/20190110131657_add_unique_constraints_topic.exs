defmodule Eventful.Repo.Migrations.AddUniqueConstraintsTopic do
  use Ecto.Migration

  def change do
    create unique_index(:topics, [:identifier])
  end
end
