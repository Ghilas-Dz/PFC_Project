defmodule Backend.Repo.Migrations.CreateEnseigner do
  use Ecto.Migration

  def change do
    create table(:enseigner) do
      add :annee_academique_enseigner, :string
      add :semestre_enseigner, :string
      add :date_debut_enseigner, :date
      add :date_fin_enseigner, :date
      add :professeur_id, references(:professeurs, on_delete: :delete_all), null: false
      add :module_id, references(:module, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:enseigner, [:professeur_id])
    create index(:enseigner, [:module_id])
    create unique_index(:enseigner, [:professeur_id, :module_id, :annee_academique_enseigner, :semestre_enseigner])
  end
end
