defmodule EventfulWeb.Api.SubscriptionController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.Subscription

  action_fallback EventfulWeb.FallbackController

  def index(conn, _params) do
    subscriptions = Resources.list_subscriptions()
    render(conn, "index.json", subscriptions: subscriptions)
  end

  def create(conn, %{"subscription" => subscription_params}) do
    subscription_params = serialized_subscription_params(subscription_params)

    with {:ok, %Subscription{} = subscription} <- Resources.create_subscription(subscription_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_subscription_path(conn, :show, subscription))
      |> render("show.json", subscription: subscription)
    end
  end

  def show(conn, %{"id" => id}) do
    subscription = Resources.get_subscription!(id)
    render(conn, "show.json", subscription: subscription)
  end

  def update(conn, %{"id" => id, "subscription" => subscription_params}) do
    subscription = Resources.get_subscription!(id)

    subscription_params = serialized_subscription_params(subscription_params)

    with {:ok, %Subscription{} = subscription} <- Resources.update_subscription(subscription, subscription_params) do
      render(conn, "show.json", subscription: subscription)
    end
  end

  def delete(conn, %{"id" => id}) do
    subscription = Resources.get_subscription!(id)

    with {:ok, %Subscription{}} <- Resources.delete_subscription(subscription) do
      send_resp(conn, :no_content, "")
    end
  end

  defp serialized_subscription_params(subscription_params) do
    Map.merge(subscription_params, %{
      "headers" => Poison.encode!(
        Map.get(subscription_params, "headers", "")
      )
    })
  end
end
