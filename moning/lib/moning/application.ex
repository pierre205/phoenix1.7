defmodule Moning.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MoningWeb.Telemetry,
      # Start the Ecto repository
      Moning.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Moning.PubSub},
      # Start Finch
      {Finch, name: Moning.Finch},
      # Start the Endpoint (http/https)
      MoningWeb.Endpoint
      # Start a worker by calling: Moning.Worker.start_link(arg)
      # {Moning.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Moning.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MoningWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
