defmodule Backend.Support.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :portee_ticket, :string
    field :referance_ticket, :string
    field :type_ticket, :string
    field :categorie_ticket, :string
    field :object_ticket, :string
    field :description_ticket, :string
    field :statut_ticket, :string
    field :priorite_ticket, :string
    field :note_satisfaction_ticket, :integer
    field :cree_le_ticket, :utc_datetime

    belongs_to :utilisateur, Backend.Accounts.Utilisateur

    has_many :commentaires, Backend.Support.Commentaire
    has_many :notifications, Backend.Support.Notification

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:portee_ticket, :referance_ticket, :type_ticket, :categorie_ticket, :object_ticket, :description_ticket, :statut_ticket, :priorite_ticket, :note_satisfaction_ticket, :cree_le_ticket, :utilisateur_id])
    |> validate_required([:portee_ticket, :referance_ticket, :type_ticket, :categorie_ticket, :object_ticket, :description_ticket, :statut_ticket, :priorite_ticket])
    |> unique_constraint(:referance_ticket)
    |> foreign_key_constraint(:utilisateur_id)
  end
end
