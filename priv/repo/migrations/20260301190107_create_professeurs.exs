defmodule Backend.Repo.Migrations.CreateProfesseurs do
  use Ecto.Migration

  def change do
    create table(:professeurs) do
      add :matricule, :string, null: false
      add :specialite, :string
      add :grade, :string
      add :telephone, :string
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:professeurs, [:matricule])
    create index(:professeurs, [:utilisateur_id])
  end
end
