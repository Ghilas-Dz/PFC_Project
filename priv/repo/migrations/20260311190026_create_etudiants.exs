defmodule Backend.Repo.Migrations.CreateEtudiants do
  use Ecto.Migration

  def change do
    create table(:etudiants) do
      add :est_delegue_etudiant, :boolean, default: false, null: false
      add :date_naissance_etudiant, :date
      add :telephone_etudiant, :string
      add :groupe_id, references(:groupes, on_delete: :nilify_all)
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:etudiants, [:groupe_id])
    create unique_index(:etudiants, [:utilisateur_id])
  end
end
