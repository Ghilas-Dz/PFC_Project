defmodule Backend.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :description, :string
    field :nom, :string

    has_many :utilisateurs, Backend.Accounts.Utilisateur

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:nom, :description])
    |> validate_required([:nom, :description])
    |> unique_constraint(:nom)
  end
end
