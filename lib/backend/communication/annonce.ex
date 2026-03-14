defmodule Backend.Communication.Annonce do
  use Ecto.Schema
  import Ecto.Changeset

  schema "annonces" do
    field :titre_annonce, :string
    field :contenu_annonce, :string
    field :date_publication_annonce, :utc_datetime

    belongs_to :utilisateur, Backend.Accounts.Utilisateur

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(annonce, attrs) do
    annonce
    |> cast(attrs, [:titre_annonce, :contenu_annonce, :date_publication_annonce, :utilisateur_id])
    |> validate_required([:titre_annonce, :contenu_annonce, :utilisateur_id])
    |> foreign_key_constraint(:utilisateur_id)
  end
end
