defmodule Backend.Academics.Groupe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groupes" do
    field :code, :string
    field :libelle, :string
    field :annee_academique, :string
    field :filiere, :string
    field :niveau, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(groupe, attrs) do
    groupe
    |> cast(attrs, [:code, :libelle, :annee_academique, :filiere, :niveau])
    |> validate_required([:code, :libelle, :annee_academique, :filiere, :niveau])
    |> unique_constraint(:code)
  end
end
