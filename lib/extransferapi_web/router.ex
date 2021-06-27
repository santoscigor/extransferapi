defmodule ExtransferapiWeb.Router do
  use ExtransferapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExtransferapiWeb do
    pipe_through :api
  end
end
