defmodule Backend.Repo.Migrations.CreateDelegueActions do
  use Ecto.Migration

  def change do
    create table(:delegue_actions) do
      add :action, :string, null: false
      add :details, :text
      add :delegue_id, references(:etudiants), null: false
      add :ticket_id, references(:tickets, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:delegue_actions, [:delegue_id])
    create index(:delegue_actions, [:ticket_id])
  end
end
