defmodule Eventful.Notifier do
  require Logger
  require HTTPoison
  alias Eventful.Resources
  alias Eventful.Repo
  use Task

  def fanout(event) do
    Enum.each(Resources.get_subscriptions_for_topic(event.topic_id), fn(subscription) ->
      max_retries = subscription.max_retries || System.get_env("max_retries")
      Exq.enqueue(Exq, "events", __MODULE__, [event.id, subscription.id], max_retries: max_retries)
    end)
  end


  def perform(event_id, subscription_id) do
    event = Repo.get(Eventful.Resources.Event, event_id)
    subscription = Repo.get(Eventful.Resources.Subscription, subscription_id)
    Logger.info("fire event: #{event.id} for subscription: #{subscription.id}")
    case HTTPoison.post(subscription.webhook, event.payload, %{"Content-Type" => "application/json"}) do
      {:ok, %{status_code: 200}} ->
        Resources.create_event_log(%{status: "ok", event_id: event.id, subscription_id: subscription.id})

      {status, response} ->
        Resources.create_event_log(%{status: "failed", event_id: event.id, subscription_id: subscription.id})
        Logger.error("status: #{status}, response: #{inspect(response)}")
        raise TaskError, "error: #{inspect(response)} for webhook #{subscription.webhook}"
    end
  end
end


defmodule TaskError do
  defexception message: "Task has failed"
end
