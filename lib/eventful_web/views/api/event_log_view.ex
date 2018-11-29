defmodule EventfulWeb.Api.EventLogView do
  use EventfulWeb, :view
  alias EventfulWeb.Api.EventLogView

  def render("index.json", %{event_logs: event_logs}) do
    %{data: render_many(event_logs, EventLogView, "event_log.json")}
  end

  def render("show.json", %{event_log: event_log}) do
    %{data: render_one(event_log, EventLogView, "event_log.json")}
  end

  def render("event_log.json", %{event_log: event_log}) do
    %{id: event_log.id,
      status: event_log.status}
  end
end
