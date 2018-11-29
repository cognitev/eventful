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
  end

  # Other scopes may use custom stacks.
  scope "/api", as: :api do
    pipe_through :api

    resources "/topics", EventfulWeb.Api.TopicController
  end
end
