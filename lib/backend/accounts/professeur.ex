defmodule Backend.Accounts.Professeur do
  use Ecto.Schema
  import Ecto.Changeset

  schema "professeurs" do
    field(:grade_professeurs, :string)
    field(:telephone_professeurs, :string)
    field(:specialite_professeurs, :string)
    belongs_to(:utilisateur, Backend.Accounts.Utilisateur)

    many_to_many(:modules, Backend.Academics.Module, join_through: "enseigner")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(professeur, attrs) do
    professeur
    |> cast(attrs, [
      :grade_professeurs,
      :telephone_professeurs,
      :specialite_professeurs,
      :utilisateur_id
    ])
    |> validate_required([
      :grade_professeurs,
      :telephone_professeurs,
      :specialite_professeurs,
      :utilisateur_id
    ])
    |> foreign_key_constraint(:utilisateur_id)
  end
end
