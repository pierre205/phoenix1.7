defmodule Moning.Portfolio do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "portfolios" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    timestamps()
  end

  @doc false
  def changeset(portfolio, attrs) do
    portfolio
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
