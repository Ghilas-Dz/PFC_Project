defmodule Backend.Support.Commentaire do
  use Ecto.Schema
  import Ecto.Changeset

  schema "commentaires" do
    field :contenu_commentaires, :string
    field :interne_commentaires, :boolean, default: false

    belongs_to :ticket, Backend.Support.Ticket
    belongs_to :utilisateur, Backend.Accounts.Utilisateur

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(commentaire, attrs) do
    commentaire
    |> cast(attrs, [:contenu_commentaires, :interne_commentaires, :ticket_id, :utilisateur_id])
    |> validate_required([:contenu_commentaires, :ticket_id])
    |> foreign_key_constraint(:ticket_id)
    |> foreign_key_constraint(:utilisateur_id)
  end
end
