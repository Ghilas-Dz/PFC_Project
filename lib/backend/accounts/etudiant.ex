defmodule Backend.Accounts.Etudiant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "etudiants" do
    field(:est_delegue_etudiant, :boolean, default: false)
    field(:date_naissance_etudiant, :date)
    field(:telephone_etudiant, :string)
    belongs_to(:groupe, Backend.Academics.Groupe)
    belongs_to(:utilisateur, Backend.Accounts.Utilisateur)

    has_many(:souggestions, Backend.Communication.Souggestion)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(etudiant, attrs) do
    etudiant
    |> cast(attrs, [
      :est_delegue_etudiant,
      :date_naissance_etudiant,
      :telephone_etudiant,
      :groupe_id,
      :utilisateur_id
    ])
    |> validate_required([
      :date_naissance_etudiant,
      :telephone_etudiant,
      :utilisateur_id,
      :groupe_id
    ])
    |> unique_constraint(:utilisateur_id)
    |> foreign_key_constraint(:groupe_id)
    |> foreign_key_constraint(:utilisateur_id)
  end
end
