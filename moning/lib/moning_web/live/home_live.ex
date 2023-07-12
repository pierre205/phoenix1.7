defmodule MoningWeb.MoningWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    users = Moning.Dashboard.last_monthly_users()

    {:ok, assign(socket, message: "Welcome to moning!", users: users, serie: users_to_serie(users))}
  end

  def render(assigns) do
    ~L"""
    <div>
    <h1><%= @message %></h1>
    <div id="container" class="h-310 w-800" data-serie={Jason.encode!(@serie)}></div>
      <ul>
        <%= for user <- @users do %>
          <li><%= user.date %>: <%= user.count %></li>
        <% end %>
      </ul>
    </div>
    """
  end

  # Convertir les utilisateurs en série de données
  defp users_to_serie(users) do
    users
    |> Enum.map(fn %{date: date, count: count} -> %{x: date, y: count} end)
  end
end
