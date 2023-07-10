defmodule Moning.Dashboard do
  import Ecto.Query
  alias Moning.{Repo, User}

    def last_monthly_users do
      from(u in User,
        where: u.inserted_at > ago(2, "year"),
        select: %{date: fragment("date(?)", u.inserted_at), count: count(u.id)},
        group_by: fragment("date(?)", u.inserted_at),
        order_by: [asc: fragment("date(?)", u.inserted_at)]
      )
      |> Repo.all()
    end

end
