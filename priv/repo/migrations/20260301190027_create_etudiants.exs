defmodule Backend.Repo.Migrations.CreateEtudiants do
  use Ecto.Migration

  def change do
    create table(:etudiants) do
      add :numero_etudiant, :string, null: false
      add :est_delegue, :boolean, default: false, null: false
      add :delegue_depuis, :utc_datetime
      add :date_naissance, :date
      add :telephone, :string
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false
      add :groupe_id, references(:groupes, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:etudiants, [:numero_etudiant])
    create index(:etudiants, [:utilisateur_id])
    create index(:etudiants, [:groupe_id])
  end
end
