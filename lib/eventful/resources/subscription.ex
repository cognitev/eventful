defmodule Eventful.Resources.Subscription do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subscriptions" do
    field :webhook, :string

    timestamps()

    belongs_to :topic, Eventful.Resources.Topic
    has_many :event_logs, Eventful.Resources.EventLog
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:webhook])
    |> validate_required([:webhook])
  end
end
