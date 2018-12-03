defmodule EventfulWeb.Api.EventLogControllerTest do
  use EventfulWeb.ConnCase

  alias Eventful.Resources
  alias Eventful.Resources.EventLog

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_logs", %{conn: conn} do
      conn = get(conn, Routes.api_event_log_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
