defmodule Eventful.Resources.EventLog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "event_logs" do
    field :status, :string
    field :subscription_id, :id
    field :event_id, :id

    timestamps()
  end

  @doc false
  def changeset(event_log, attrs) do
    event_log
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
