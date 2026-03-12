defmodule Backend.Academics.Groupe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groupes" do
    field :code_groupes, :string
    field :libele_groupes, :string
    field :annee_academique_groupes, :string
    field :filier_groupe, :string
    field :niveau_groupe, :string

    has_many :etudiants, Backend.Accounts.Etudiant
    many_to_many :modules, Backend.Academics.Module, join_through: "groupes_modules"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(groupe, attrs) do
    groupe
    |> cast(attrs, [:code_groupes, :libele_groupes, :annee_academique_groupes, :filier_groupe, :niveau_groupe])
    |> validate_required([:code_groupes, :libele_groupes, :annee_academique_groupes, :filier_groupe, :niveau_groupe])
    |> unique_constraint(:code_groupes)
  end
end
