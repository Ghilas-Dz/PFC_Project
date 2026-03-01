defmodule Backend.Support.AuditLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "audit_logs" do
    field :action, :string
    field :details, :string
    field :ancien_statut, :string
    field :nouveau_statut, :string
    field :ip_adresse, :string
    belongs_to :ticket, Backend.Support.Ticket, foreign_key: :ticket_id
    belongs_to :acteur, Backend.Accounts.Utilisateur, foreign_key: :acteur_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(audit_log, attrs) do
    audit_log
    |> cast(attrs, [
      :action,
      :ancien_statut,
      :nouveau_statut,
      :details,
      :ip_adresse,
      :ticket_id,
      :acteur_id
    ])
    |> validate_required([:action, :ancien_statut, :nouveau_statut, :details, :ip_adresse])
    |> foreign_key_constraint(:ticket_id)
    |> foreign_key_constraint(:acteur_id)
  end
end
