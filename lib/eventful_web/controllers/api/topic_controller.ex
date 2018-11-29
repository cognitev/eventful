defmodule EventfulWeb.Api.TopicController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.Topic

  action_fallback EventfulWeb.FallbackController

  def index(conn, _params) do
    topics = Resources.list_topics()
    render(conn, "index.json", topics: topics)
  end

  def create(conn, %{"topic" => topic_params}) do
    with {:ok, %Topic{} = topic} <- Resources.create_topic(topic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_topic_path(conn, :show, topic))
      |> render("show.json", topic: topic)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Resources.get_topic!(id)
    render(conn, "show.json", topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Resources.get_topic!(id)

    with {:ok, %Topic{} = topic} <- Resources.update_topic(topic, topic_params) do
      render(conn, "show.json", topic: topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Resources.get_topic!(id)

    with {:ok, %Topic{}} <- Resources.delete_topic(topic) do
      send_resp(conn, :no_content, "")
    end
  end
end
