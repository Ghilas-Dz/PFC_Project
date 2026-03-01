defmodule Backend.Support.Commentaire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "commentaires" do
    field :contenu, :string
    field :interne, :boolean, default: false
    belongs_to :ticket, Backend.Support.Ticket, foreign_key: :ticket_id
    belongs_to :auteur, Backend.Accounts.Utilisateur, foreign_key: :auteur_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(commentaire, attrs) do
    commentaire
    |> cast(attrs, [:contenu, :interne, :ticket_id, :auteur_id])
    |> validate_required([:contenu, :interne, :ticket_id, :auteur_id])
    |> foreign_key_constraint(:ticket_id)
    |> foreign_key_constraint(:auteur_id)
  end
end
