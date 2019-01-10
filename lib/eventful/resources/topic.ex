defmodule Eventful.Resources.Topic do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :description, :string
    field :identifier, :string

    timestamps()

    has_many :subscriptions, Eventful.Resources.Subscription
    has_many :events, Eventful.Resources.Event
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:identifier, :description])
    |> validate_required([:identifier, :description])
    |> unique_constraint(:identifier)
  end
end
