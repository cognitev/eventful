defmodule EventfulWeb.Api.EventLogControllerTest do
  use EventfulWeb.ConnCase

  alias Eventful.Resources
  alias Eventful.Resources.EventLog

  @create_attrs %{
    status: "some status"
  }
  @update_attrs %{
    status: "some updated status"
  }
  @invalid_attrs %{status: nil}

  def fixture(:event_log) do
    {:ok, event_log} = Resources.create_event_log(@create_attrs)
    event_log
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_logs", %{conn: conn} do
      conn = get(conn, Routes.api_event_log_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event_log" do
    test "renders event_log when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_event_log_path(conn, :create), event_log: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_event_log_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_event_log_path(conn, :create), event_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event_log" do
    setup [:create_event_log]

    test "renders event_log when data is valid", %{conn: conn, event_log: %EventLog{id: id} = event_log} do
      conn = put(conn, Routes.api_event_log_path(conn, :update, event_log), event_log: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_event_log_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event_log: event_log} do
      conn = put(conn, Routes.api_event_log_path(conn, :update, event_log), event_log: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event_log" do
    setup [:create_event_log]

    test "deletes chosen event_log", %{conn: conn, event_log: event_log} do
      conn = delete(conn, Routes.api_event_log_path(conn, :delete, event_log))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_event_log_path(conn, :show, event_log))
      end
    end
  end

  defp create_event_log(_) do
    event_log = fixture(:event_log)
    {:ok, event_log: event_log}
  end
end
