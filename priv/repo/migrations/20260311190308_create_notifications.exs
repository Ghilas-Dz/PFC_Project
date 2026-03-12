defmodule Backend.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :type_notifications, :string
      add :message_notifications, :text
      add :cree_le_notifications, :utc_datetime
      add :lien_notifications, :string
      add :pour_tous, :boolean, default: false, null: false
      add :ticket_id, references(:tickets, on_delete: :delete_all)
      add :utilisateur_id, references(:utilisateurs, on_delete: :nilify_all)

      timestamps(type: :utc_datetime)
    end

    create index(:notifications, [:ticket_id])
    create index(:notifications, [:utilisateur_id])
  end
end
