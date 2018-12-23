defmodule Eventful.Resources.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :webhook, :max_retries, :topic_id]}
  schema "subscriptions" do
    field :webhook, :string
    field :max_retries, :integer, default: 0

    timestamps()

    belongs_to :topic, Eventful.Resources.Topic
    has_many :event_logs, Eventful.Resources.EventLog
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:webhook, :topic_id, :max_retries])
    |> validate_required([:webhook])
  end
end
