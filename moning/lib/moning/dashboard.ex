defmodule Moning.Dashboard do
  import Ecto.Query
  alias Moning.{Repo, User, Portfolio, User_following}

    def last_monthly_users do
      from(u in User,
        where: u.inserted_at > ago(4, "year"),
        select: %{date: fragment("date(?)", u.inserted_at), count: count(u.id)},
        group_by: fragment("date(?)", u.inserted_at),
        order_by: [asc: fragment("date(?)", u.inserted_at)]
      )
      |> Repo.all()
    end

    def last_monthly_portfolios do
      from(u in Portfolio,
        where: u.inserted_at > ago(4, "year"),
        select: %{date: fragment("date(?)", u.inserted_at), count: count(u.id)},
        group_by: fragment("date(?)", u.inserted_at),
        order_by: [asc: fragment("date(?)", u.inserted_at)]
      )
      |> Repo.all()
    end

    def last_monthly_usersfollowings do
      from(u in User_following,
        where: u.inserted_at > ago(4, "year"),
        where: u.inserted_at > ago(4, "year"),
        select: %{date: fragment("date(?)", u.inserted_at), count: count(u.id)},
        group_by: fragment("date(?)", u.inserted_at),
        order_by: [asc: fragment("date(?)", u.inserted_at)]
      )
      |> Repo.all()
    end
end
