defmodule Eventful.Resources do
  @moduledoc """
  The Resources context.
  """

  import Ecto.Query, warn: false
  alias Eventful.Repo

  alias Eventful.Resources.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  alias Eventful.Resources.Subscription

  @doc """
  Returns the list of subscriptions.

  ## Examples

      iex> list_subscriptions()
      [%Subscription{}, ...]

  """
  def list_subscriptions do
    Repo.all(Subscription)
  end

  def get_subscriptions_for_topic(topic_id) do
    q = from c in Subscription,
        where: [topic_id: ^topic_id],
        select: c
    Repo.all(q)

  end


  def get_topic_by_identifier(topic_identifier) do
    query = from t in Topic,
          where: [identifier: ^topic_identifier],
          select: t
    List.first(Repo.all(query))
  end  
  @doc """
  Gets a single subscription.

  Raises `Ecto.NoResultsError` if the Subscription does not exist.

  ## Examples

      iex> get_subscription!(123)
      %Subscription{}

      iex> get_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscription!(id), do: Repo.get!(Subscription, id)

  @doc """
  Creates a subscription.

  ## Examples

      iex> create_subscription(%{field: value})
      {:ok, %Subscription{}}

      iex> create_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscription(attrs \\ %{}) do
    %Subscription{}
    |> Subscription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subscription.

  ## Examples

      iex> update_subscription(subscription, %{field: new_value})
      {:ok, %Subscription{}}

      iex> update_subscription(subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscription(%Subscription{} = subscription, attrs) do
    subscription
    |> Subscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Subscription.

  ## Examples

      iex> delete_subscription(subscription)
      {:ok, %Subscription{}}

      iex> delete_subscription(subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscription(%Subscription{} = subscription) do
    Repo.delete(subscription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscription changes.

  ## Examples

      iex> change_subscription(subscription)
      %Ecto.Changeset{source: %Subscription{}}

  """
  def change_subscription(%Subscription{} = subscription) do
    Subscription.changeset(subscription, %{})
  end

  alias Eventful.Resources.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias Eventful.Resources.EventLog

  @doc """
  Returns the list of event_logs.

  ## Examples

      iex> list_event_logs()
      [%EventLog{}, ...]

  """
  def list_event_logs do
    Repo.all(EventLog)
  end

  @doc """
  Gets a single event_log.

  Raises `Ecto.NoResultsError` if the Event log does not exist.

  ## Examples

      iex> get_event_log!(123)
      %EventLog{}

      iex> get_event_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_log!(id), do: Repo.get!(EventLog, id)

  @doc """
  Creates a event_log.

  ## Examples

      iex> create_event_log(%{field: value})
      {:ok, %EventLog{}}

      iex> create_event_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_log(attrs \\ %{}) do
    %EventLog{}
    |> EventLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_log.

  ## Examples

      iex> update_event_log(event_log, %{field: new_value})
      {:ok, %EventLog{}}

      iex> update_event_log(event_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_log(%EventLog{} = event_log, attrs) do
    event_log
    |> EventLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a EventLog.

  ## Examples

      iex> delete_event_log(event_log)
      {:ok, %EventLog{}}

      iex> delete_event_log(event_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_log(%EventLog{} = event_log) do
    Repo.delete(event_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_log changes.

  ## Examples

      iex> change_event_log(event_log)
      %Ecto.Changeset{source: %EventLog{}}

  """
  def change_event_log(%EventLog{} = event_log) do
    EventLog.changeset(event_log, %{})
  end
end
