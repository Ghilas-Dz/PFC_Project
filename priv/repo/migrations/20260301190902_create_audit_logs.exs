defmodule Backend.Repo.Migrations.CreateAuditLogs do
  use Ecto.Migration

  def change do
    create table(:audit_logs) do
      add :action, :string
      add :ancien_statut, :string
      add :nouveau_statut, :string
      add :details, :text
      add :ip_adresse, :string
      add :ticket_id, references(:tickets, on_delete: :delete_all), null: false
      add :acteur_id, references(:utilisateurs), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:audit_logs, [:ticket_id])
    create index(:audit_logs, [:acteur_id])
  end
end
