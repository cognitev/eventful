defmodule EventfulWeb.Api.SubscriptionView do
  use EventfulWeb, :view
  alias EventfulWeb.Api.SubscriptionView

  def render("index.json", %{subscriptions: subscriptions}) do
    %{data: render_many(subscriptions, SubscriptionView, "subscription.json")}
  end

  def render("show.json", %{subscription: subscription}) do
    %{data: render_one(subscription, SubscriptionView, "subscription.json")}
  end

  def render("subscription.json", %{subscription: subscription}) do
    %{id: subscription.id,
      webhook: subscription.webhook}
  end
end
