defmodule Backend.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :reference, :string, null: false
      add :portee, :string, default: "individuel", null: false
      add :type, :string, null: false
      add :categorie, :string
      add :objet, :string, null: false
      add :description, :text, null: false
      add :statut, :string, default: "ouvert", null: false
      add :priorite, :string, default: "normale", null: false
      add :note_satisfaction, :integer
      add :resolu_le, :utc_datetime
      add :createur_id, references(:etudiants), null: false
      add :groupe_concerne_id, references(:groupes, on_delete: :nothing)
      add :cours_id, references(:cours, on_delete: :nothing)
      add :assigne_prof_id, references(:professeurs, on_delete: :nothing)
      add :assigne_admin_id, references(:administration, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:tickets, [:reference])
    create index(:tickets, [:createur_id])
    create index(:tickets, [:groupe_concerne_id])
    create index(:tickets, [:cours_id])
    create index(:tickets, [:assigne_prof_id])
    create index(:tickets, [:assigne_admin_id])

    create constraint(:tickets, :assignation_xor,
             check: """
             (assigne_prof_id IS NOT NULL AND assigne_admin_id IS NULL)
             OR
             (assigne_prof_id IS NULL AND assigne_admin_id IS NOT NULL)
             OR
             (assigne_prof_id IS NULL AND assigne_admin_id IS NULL)
             """
           )
  end
end
