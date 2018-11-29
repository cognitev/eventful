defmodule EventfulWeb.Api.EventLogController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.EventLog

  action_fallback EventfulWeb.FallbackController

  def index(conn, _params) do
    event_logs = Resources.list_event_logs()
    render(conn, "index.json", event_logs: event_logs)
  end

  def create(conn, %{"event_log" => event_log_params}) do
    with {:ok, %EventLog{} = event_log} <- Resources.create_event_log(event_log_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_event_log_path(conn, :show, event_log))
      |> render("show.json", event_log: event_log)
    end
  end

  def show(conn, %{"id" => id}) do
    event_log = Resources.get_event_log!(id)
    render(conn, "show.json", event_log: event_log)
  end

  def update(conn, %{"id" => id, "event_log" => event_log_params}) do
    event_log = Resources.get_event_log!(id)

    with {:ok, %EventLog{} = event_log} <- Resources.update_event_log(event_log, event_log_params) do
      render(conn, "show.json", event_log: event_log)
    end
  end

  def delete(conn, %{"id" => id}) do
    event_log = Resources.get_event_log!(id)

    with {:ok, %EventLog{}} <- Resources.delete_event_log(event_log) do
      send_resp(conn, :no_content, "")
    end
  end
end
