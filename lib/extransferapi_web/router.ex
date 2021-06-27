defmodule ExtransferapiWeb.Router do
  use ExtransferapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExtransferapiWeb do
    pipe_through :api

    get "/accounts/balance", AccountController, :get_balance

    post "/auth/login", AuthController, :login
    post "/auth/register", AuthController, :register
  end
end
