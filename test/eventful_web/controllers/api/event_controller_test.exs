defmodule EventfulWeb.Api.EventControllerTest do
  use EventfulWeb.ConnCase

  alias Eventful.Resources
  alias Eventful.Resources.Event

  @create_attrs %{
    payload: %{a: 3},
    sender_info: "some sender_info",
    topic_identifier: "topic"
  }
  @create_topic %{description: "some description", identifier: "topic"}

  @invalid_attrs %{payload: nil, sender_info: nil, topic_identifier: "topic"}

  def fixture(:event) do
    {:ok, event} = Resources.create_event(@create_attrs)
    event
  end

  def fixture(:topic) do
    {:ok, topic} = Resources.create_topic(@create_topic)
    {:ok, topic: [topic]} 
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.api_event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end


  describe "create event" do
    setup _topic do
      fixture(:topic)
    end

    test "renders event when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_event_path(conn, :create), event: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_event_path(conn, :show, id))

      assert %{
               "id" => id,
               "payload" => "{\"a\":3}",
               "sender_info" => "some sender_info"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_event_path(conn, :create), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_event(_) do
    event = fixture(:event)
    {:ok, event: event}
  end

  defp create_topic(_) do
    topic = fixture(:topic)
    {:ok, topic: topic}
  end
end
