defmodule Backend.Communication.Souggestion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "souggestions" do
    field :titre_souggestion, :string
    field :contenu_souggestion, :string
    field :like_souggestion, :integer
    field :dislike_souggestion, :integer

    belongs_to :etudiant, Backend.Accounts.Etudiant

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(souggestion, attrs) do
    souggestion
    |> cast(attrs, [:titre_souggestion, :contenu_souggestion, :like_souggestion, :dislike_souggestion, :etudiant_id])
    |> validate_required([:titre_souggestion, :contenu_souggestion, :etudiant_id])
    |> foreign_key_constraint(:etudiant_id)
  end
end
