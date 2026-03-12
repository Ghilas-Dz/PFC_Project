defmodule Backend.Academics.Enseigner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "enseigner" do
    field(:annee_academique_enseigner, :string)
    field(:semestre_enseigner, :string)
    field(:date_debut_enseigner, :date)
    field(:date_fin_enseigner, :date)

    belongs_to(:professeur, Backend.Accounts.Professeur)
    belongs_to(:module, Backend.Academics.Module)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(enseigner, attrs) do
    enseigner
    |> cast(attrs, [
      :annee_academique_enseigner,
      :semestre_enseigner,
      :date_debut_enseigner,
      :date_fin_enseigner,
      :professeur_id,
      :module_id
    ])
    |> validate_required([
      :annee_academique_enseigner,
      :semestre_enseigner,
      :date_debut_enseigner,
      :date_fin_enseigner,
      :professeur_id,
      :module_id
    ])
    |> foreign_key_constraint(:professeur_id)
    |> foreign_key_constraint(:module_id)
  end
end
