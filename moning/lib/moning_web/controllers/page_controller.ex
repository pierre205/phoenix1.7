
defmodule MoningWeb.PageController do
  use MoningWeb, :controller

  def home(conn, _params) do
    users = Moning.Dashboard.last_monthly_users()

    render(conn, :home, message: "Welcome to moning!", users: users, serie: (users |> Enum.map(fn %{date: date, count: count} -> %{x: date, y: count} end)))
  end
end
