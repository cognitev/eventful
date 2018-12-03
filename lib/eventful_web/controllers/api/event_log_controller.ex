defmodule EventfulWeb.Api.EventLogController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.EventLog

  action_fallback EventfulWeb.FallbackController

  def index(conn, _params) do
    event_logs = Resources.list_event_logs()
    render(conn, "index.json", event_logs: event_logs)
  end
end
