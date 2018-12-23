defmodule Eventful.Notifier do
  require Logger
  require HTTPoison
  alias Eventful.Resources
  use Task

  def fanout(event) do
    Enum.each(Resources.get_subscriptions_for_topic(event.topic_id), fn(subscription) ->
      Exq.enqueue(Exq, "events", __MODULE__, [event, subscription], max_retries: subscription.max_retries)
    end)
  end


  def perform(event, subscription) do
    Logger.info("fire event: #{event["id"]} for subscription: #{subscription["id"]}")
    case HTTPoison.post(subscription["webhook"], event["payload"], %{"Content-Type" => "application/json"}) do
      {:ok, %{status_code: 200}} ->
        Resources.create_event_log(%{status: "ok", event_id: event["id"], subscription_id: subscription["id"]})

      {status, response} ->
        Resources.create_event_log(%{status: "failed", event_id: event["id"], subscription_id: subscription["id"]})
        Logger.error("status: #{status}, response: #{inspect(response)}")
        raise TaskError
    end
  end
end


defmodule TaskError do
  defexception message: "Task has failed"
end
