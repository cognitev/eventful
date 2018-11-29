defmodule EventfulWeb.SubscriptionController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.Subscription

  def index(conn, _params) do
    subscriptions = Resources.list_subscriptions()
    render(conn, "index.html", subscriptions: subscriptions)
  end

  def new(conn, _params) do
    changeset = Resources.change_subscription(%Subscription{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subscription" => subscription_params}) do
    case Resources.create_subscription(subscription_params) do
      {:ok, subscription} ->
        conn
        |> put_flash(:info, "Subscription created successfully.")
        |> redirect(to: Routes.subscription_path(conn, :show, subscription))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subscription = Resources.get_subscription!(id)
    render(conn, "show.html", subscription: subscription)
  end

  def edit(conn, %{"id" => id}) do
    subscription = Resources.get_subscription!(id)
    changeset = Resources.change_subscription(subscription)
    render(conn, "edit.html", subscription: subscription, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subscription" => subscription_params}) do
    subscription = Resources.get_subscription!(id)

    case Resources.update_subscription(subscription, subscription_params) do
      {:ok, subscription} ->
        conn
        |> put_flash(:info, "Subscription updated successfully.")
        |> redirect(to: Routes.subscription_path(conn, :show, subscription))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subscription: subscription, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subscription = Resources.get_subscription!(id)
    {:ok, _subscription} = Resources.delete_subscription(subscription)

    conn
    |> put_flash(:info, "Subscription deleted successfully.")
    |> redirect(to: Routes.subscription_path(conn, :index))
  end
end
