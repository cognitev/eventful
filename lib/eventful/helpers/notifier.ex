defmodule Eventful.Notifier do
  require Logger
  require HTTPoison
  alias Eventful.Resources
  use Task

  def fanout(event) do
    Enum.each(Resources.get_subscriptions_for_topic(event.topic_id), fn(subscription) ->
      Task.async(__MODULE__, :fire, [event, subscription])
    end)
  end


  def fire(event, subscription) do
    Logger.info("fire event: #{event.id} for subscription: #{subscription.id}")
    case HTTPoison.post(subscription.webhook, event.payload, %{"Content-Type" => "application/json"}) do
      {:ok, %{status_code: 200}} ->
        Resources.create_event_log(%{status: "ok", event_id: event.id, subscription_id: subscription.id})

      {status, response} ->
        Resources.create_event_log(%{status: "failed", event_id: event.id, subscription_id: subscription.id})
        Logger.error("status: #{status}, response: #{inspect(response)}")
    end
  end
end
