defmodule Backend.Access.Fonctionnalite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fonctionnalites" do
    field :code, :string
    field :description, :string
    field :libelle, :string
    field :dashboard, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fonctionnalite, attrs) do
    fonctionnalite
    |> cast(attrs, [:code, :libelle, :description, :dashboard])
    |> validate_required([:code, :libelle, :description, :dashboard])
    |> unique_constraint(:code)
  end
end
