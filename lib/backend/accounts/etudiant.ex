defmodule Backend.Accounts.Etudiant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "etudiants" do
    field :numero_etudiant, :string
    field :est_delegue, :boolean, default: false
    field :delegue_depuis, :utc_datetime
    field :date_naissance, :date
    field :telephone, :string
    belongs_to :utilisateur, Backend.Accounts.Utilisateur, foreign_key: :utilisateur_id
    belongs_to :groupe, Backend.Academics.Groupe, foreign_key: :groupe_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(etudiant, attrs) do
    etudiant
    |> cast(attrs, [
      :numero_etudiant,
      :est_delegue,
      :delegue_depuis,
      :date_naissance,
      :telephone,
      :utilisateur_id,
      :groupe_id
    ])
    |> validate_required([
      :numero_etudiant,
      :est_delegue,
      :delegue_depuis,
      :date_naissance,
      :telephone,
      :utilisateur_id,
      :groupe_id
    ])
    |> unique_constraint(:numero_etudiant)
    |> foreign_key_constraint(:utilisateur_id)
    |> foreign_key_constraint(:groupe_id)
  end
end
