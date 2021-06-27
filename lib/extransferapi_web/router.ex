defmodule ExtransferapiWeb.Router do
  use ExtransferapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExtransferapiWeb do
    pipe_through :api

    get "/auth", AuthController, :index
    post "/auth/login", AuthController, :login
    post "/auth/register", AuthController, :register
  end
end
