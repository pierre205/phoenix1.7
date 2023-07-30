defmodule Moning.User_following do
  use Ecto.Schema

  schema "users_followings" do
    field :user_id, :integer
    field :following_id, :integer

    timestamps()
  end
end
