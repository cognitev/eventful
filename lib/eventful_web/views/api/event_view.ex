defmodule EventfulWeb.Api.EventView do
  use EventfulWeb, :view
  alias EventfulWeb.Api.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      sender_info: event.sender_info,
      payload: event.payload}
  end
end
