defmodule Backend.Accounts.Professeur do
  use Ecto.Schema
  import Ecto.Changeset

  schema "professeurs" do
    field :matricule, :string
    field :specialite, :string
    field :grade, :string
    field :telephone, :string
    belongs_to :utilisateur, Backend.Accounts.Utilisateur, foreign_key: :utilisateur_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(professeur, attrs) do
    professeur
    |> cast(attrs, [:matricule, :specialite, :grade, :telephone, :utilisateur_id])
    |> validate_required([:matricule, :specialite, :grade, :telephone, :utilisateur_id])
    |> unique_constraint(:matricule)
    |> foreign_key_constraint(:utilisateur_id)
  end
end
