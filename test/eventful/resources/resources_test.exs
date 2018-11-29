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
end
