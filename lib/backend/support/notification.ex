defmodule Backend.Support.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field(:type_notifications, :string)
    field(:message_notifications, :string)
    field(:cree_le_notifications, :utc_datetime)
    field(:lien_notifications, :string)
    field(:pour_tous, :boolean, default: false)

    belongs_to(:ticket, Backend.Support.Ticket)
    belongs_to(:utilisateur, Backend.Accounts.Utilisateur)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [
      :type_notifications,
      :message_notifications,
      :cree_le_notifications,
      :lien_notifications,
      :pour_tous,
      :ticket_id,
      :utilisateur_id
    ])
    |> validate_required([:type_notifications, :message_notifications])
    |> validate_destinataire()
    |> foreign_key_constraint(:ticket_id)
    |> foreign_key_constraint(:utilisateur_id)
  end

  defp validate_destinataire(changeset) do
    pour_tous = Ecto.Changeset.get_field(changeset, :pour_tous)
    utilisateur_id = Ecto.Changeset.get_field(changeset, :utilisateur_id)

    cond do
      pour_tous == true ->
        changeset

      is_nil(utilisateur_id) ->
        Ecto.Changeset.add_error(
          changeset,
          :utilisateur_id,
          "doit être renseigné si la notification n'est pas pour tous"
        )

      true ->
        changeset
    end
  end
end
