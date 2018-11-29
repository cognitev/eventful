defmodule Eventful.Resources.EventLog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "event_logs" do
    field :status, :string

    timestamps()

    belongs_to :event, Eventful.Resources.Event
    belongs_to :subscription, Eventful.Resources.Subscription
  end

  @doc false
  def changeset(event_log, attrs) do
    event_log
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
