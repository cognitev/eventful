defmodule Eventful.ResourcesTest do
  use Eventful.DataCase

  alias Eventful.Resources

  describe "topics" do
    alias Eventful.Resources.Topic

    @valid_attrs %{description: "some description", identifier: "some identifier"}
    @update_attrs %{description: "some updated description", identifier: "some updated identifier"}
    @invalid_attrs %{description: nil, identifier: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_topic()

      topic
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Resources.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Resources.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Resources.create_topic(@valid_attrs)
      assert topic.description == "some description"
      assert topic.identifier == "some identifier"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{} = topic} = Resources.update_topic(topic, @update_attrs)
      assert topic.description == "some updated description"
      assert topic.identifier == "some updated identifier"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_topic(topic, @invalid_attrs)
      assert topic == Resources.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Resources.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Resources.change_topic(topic)
    end
  end

  describe "subscriptions" do
    alias Eventful.Resources.Subscription

    @valid_attrs %{webhook: "some webhook"}
    @update_attrs %{webhook: "some updated webhook"}
    @invalid_attrs %{webhook: nil}

    def subscription_fixture(attrs \\ %{}) do
      {:ok, subscription} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_subscription()

      subscription
    end

    test "list_subscriptions/0 returns all subscriptions" do
      subscription = subscription_fixture()
      assert Resources.list_subscriptions() == [subscription]
    end

    test "get_subscription!/1 returns the subscription with given id" do
      subscription = subscription_fixture()
      assert Resources.get_subscription!(subscription.id) == subscription
    end

    test "create_subscription/1 with valid data creates a subscription" do
      assert {:ok, %Subscription{} = subscription} = Resources.create_subscription(@valid_attrs)
      assert subscription.webhook == "some webhook"
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_subscription(@invalid_attrs)
    end

    test "update_subscription/2 with valid data updates the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{} = subscription} = Resources.update_subscription(subscription, @update_attrs)
      assert subscription.webhook == "some updated webhook"
    end

    test "update_subscription/2 with invalid data returns error changeset" do
      subscription = subscription_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_subscription(subscription, @invalid_attrs)
      assert subscription == Resources.get_subscription!(subscription.id)
    end

    test "delete_subscription/1 deletes the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{}} = Resources.delete_subscription(subscription)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_subscription!(subscription.id) end
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Resources.change_subscription(subscription)
    end
  end

  describe "events" do
    alias Eventful.Resources.Event

    @valid_attrs %{payload: "some payload", sender_info: "some sender_info"}
    @update_attrs %{payload: "some updated payload", sender_info: "some updated sender_info"}
    @invalid_attrs %{payload: nil, sender_info: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Resources.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Resources.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Resources.create_event(@valid_attrs)
      assert event.payload == "some payload"
      assert event.sender_info == "some sender_info"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Resources.update_event(event, @update_attrs)
      assert event.payload == "some updated payload"
      assert event.sender_info == "some updated sender_info"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_event(event, @invalid_attrs)
      assert event == Resources.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Resources.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Resources.change_event(event)
    end
  end
end
