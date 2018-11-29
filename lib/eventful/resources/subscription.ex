defmodule Eventful.Resources.Subscription do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subscriptions" do
    field :webhook, :string
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:webhook])
    |> validate_required([:webhook])
  end
end
