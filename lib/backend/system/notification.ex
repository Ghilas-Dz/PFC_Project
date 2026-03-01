defmodule Backend.System.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :message, :string
    field :type, :string
    field :lien, :string
    field :lue, :boolean, default: false
    belongs_to :destinataire, Backend.Accounts.Utilisateur, foreign_key: :destinataire_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:type, :message, :lien, :lue, :destinataire_id])
    |> validate_required([:type, :message, :lien, :lue, :destinataire_id])
    |> foreign_key_constraint(:destinataire_id)
  end
end
