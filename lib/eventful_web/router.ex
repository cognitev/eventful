defmodule EventfulWeb.Router do
  use EventfulWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventfulWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/topics", TopicController
    resources "/subscriptions", SubscriptionController
    resources "/events", EventController
    resources "/event_logs", EventLogController
  end

  # Other scopes may use custom stacks.
  scope "/api", as: :api do
    pipe_through :api

    resources "/topics", EventfulWeb.Api.TopicController
    resources "/subscriptions", EventfulWeb.Api.SubscriptionController
    resources "/events", EventfulWeb.Api.EventController, only: [:index, :show, :create]
    resources "/event_logs", EventfulWeb.Api.EventLogController, only: [:index]
  end
end
