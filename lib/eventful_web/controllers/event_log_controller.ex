defmodule EventfulWeb.EventLogController do
  use EventfulWeb, :controller

  alias Eventful.Resources
  alias Eventful.Resources.EventLog

  def index(conn, _params) do
    event_logs = Resources.list_event_logs()
    render(conn, "index.html", event_logs: event_logs)
  end

  def new(conn, _params) do
    changeset = Resources.change_event_log(%EventLog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event_log" => event_log_params}) do
    case Resources.create_event_log(event_log_params) do
      {:ok, event_log} ->
        conn
        |> put_flash(:info, "Event log created successfully.")
        |> redirect(to: Routes.event_log_path(conn, :show, event_log))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event_log = Resources.get_event_log!(id)
    render(conn, "show.html", event_log: event_log)
  end

  def edit(conn, %{"id" => id}) do
    event_log = Resources.get_event_log!(id)
    changeset = Resources.change_event_log(event_log)
    render(conn, "edit.html", event_log: event_log, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event_log" => event_log_params}) do
    event_log = Resources.get_event_log!(id)

    case Resources.update_event_log(event_log, event_log_params) do
      {:ok, event_log} ->
        conn
        |> put_flash(:info, "Event log updated successfully.")
        |> redirect(to: Routes.event_log_path(conn, :show, event_log))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event_log: event_log, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event_log = Resources.get_event_log!(id)
    {:ok, _event_log} = Resources.delete_event_log(event_log)

    conn
    |> put_flash(:info, "Event log deleted successfully.")
    |> redirect(to: Routes.event_log_path(conn, :index))
  end
end
