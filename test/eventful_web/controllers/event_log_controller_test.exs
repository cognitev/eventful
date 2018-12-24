defmodule EventfulWeb.EventLogControllerTest do
  use EventfulWeb.ConnCase

  alias Eventful.Resources

  @create_attrs %{status: "some status"}
  @update_attrs %{status: "some updated status"}
  @invalid_attrs %{status: nil}

  def fixture(:event_log) do
    {:ok, event_log} = Resources.create_event_log(@create_attrs)
    event_log
  end

  describe "index" do
    test "lists all event_logs", %{conn: conn} do
      conn = get(conn, Routes.event_log_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Event logs"
    end
  end

  describe "new event_log" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.event_log_path(conn, :new))
      assert html_response(conn, 200) =~ "New Event log"
    end
  end

  describe "create event_log" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.event_log_path(conn, :create), event_log: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.event_log_path(conn, :show, id)

      conn = get(conn, Routes.event_log_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Event log"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.event_log_path(conn, :create), event_log: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Event log"
    end
  end

  describe "edit event_log" do
    setup [:create_event_log]

    test "renders form for editing chosen event_log", %{conn: conn, event_log: event_log} do
      conn = get(conn, Routes.event_log_path(conn, :edit, event_log))
      assert html_response(conn, 200) =~ "Edit Event log"
    end
  end

  describe "update event_log" do
    setup [:create_event_log]

    test "redirects when data is valid", %{conn: conn, event_log: event_log} do
      conn = put(conn, Routes.event_log_path(conn, :update, event_log), event_log: @update_attrs)
      assert redirected_to(conn) == Routes.event_log_path(conn, :show, event_log)

      conn = get(conn, Routes.event_log_path(conn, :show, event_log))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, event_log: event_log} do
      conn = put(conn, Routes.event_log_path(conn, :update, event_log), event_log: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Event log"
    end
  end

  describe "delete event_log" do
    setup [:create_event_log]

    test "deletes chosen event_log", %{conn: conn, event_log: event_log} do
      conn = delete(conn, Routes.event_log_path(conn, :delete, event_log))
      assert redirected_to(conn) == Routes.event_log_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.event_log_path(conn, :show, event_log))
      end
    end
  end

  defp create_event_log(_) do
    event_log = fixture(:event_log)
    {:ok, event_log: event_log}
  end
end
