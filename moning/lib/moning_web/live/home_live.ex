defmodule MoningWeb.MoningWeb.HomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    users = Moning.Dashboard.last_monthly_users()
    portfolios = Moning.Dashboard.last_monthly_portfolios()
    users_followings = Moning.Dashboard.last_monthly_usersfollowings()
    serie_users = users_to_serie(users)
    serie_portfolios = portfolios_to_serie(portfolios)
    serie_users_followings = users_followings_to_serie(users_followings)
    {:ok, assign(socket, message: "Welcome to moning!", users: users, portfolios: portfolios, serie_users: serie_users, serie_portfolios: serie_portfolios, serie_users_followings: serie_users_followings)}

  end

  def render(assigns) do
    ~H"""
    <div>
      <h1><%= @message %></h1>
      <div id="container" data-serie={Jason.encode!(@serie_users)} phx-update="ignore"></div>
      <div id="container2" data-serie={Jason.encode!(@serie_portfolios)} phx-update="ignore"></div>
      <div id="container3" data-serie={Jason.encode!(@serie_users_followings)} phx-update="ignore"></div>
    </div>
    """
  end
  # Convertir les utilisateurs en série de données
  defp users_to_serie(users) do
    users
    |> Enum.map(fn %{date: date, count: count} -> %{x: date, y: count} end)
  end
  # Convertir les portfolios en série de données
  defp portfolios_to_serie(portfolios) do
    portfolios
    |> Enum.map(fn %{date: date, count: count} -> %{x: date, y: count} end)
  end

  # Convertir les utilisateurs_followings en série de données
  defp users_followings_to_serie(users_followings) do
    users_followings
    |> Enum.map(fn %{date: date, count: count} -> %{x: date, y: count} end)
  end
end
