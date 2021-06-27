defmodule Extransferapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  {Phoenix.PubSub, [name: Extransferapi.PubSub, adapter: Phoenix.PubSub.PG2]}

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Extransferapi.Repo,
      # Start the endpoint when the application starts
      ExtransferapiWeb.Endpoint
      # Starts a worker by calling: Extransferapi.Worker.start_link(arg)
      # {Extransferapi.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Extransferapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExtransferapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
