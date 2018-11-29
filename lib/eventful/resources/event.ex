defmodule Eventful.Resources.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :payload, :string
    field :sender_info, :string

    timestamps()

    belongs_to :topic, Eventful.Resources.Topic
    has_many :event_logs, Eventful.Resources.EventLog
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:sender_info, :payload])
    |> validate_required([:sender_info, :payload])
  end
end
