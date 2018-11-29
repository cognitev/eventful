defmodule Eventful.Resources.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :payload, :string
    field :sender_info, :string
    field :topic_id, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:sender_info, :payload])
    |> validate_required([:sender_info, :payload])
  end
end
