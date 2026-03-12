defmodule Backend.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field(:nom_roles, :string)

    has_many(:utilisateurs, Backend.Accounts.Utilisateur)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:nom_roles])
    |> validate_required([:nom_roles])
    |> unique_constraint(:nom_roles)
  end
end
