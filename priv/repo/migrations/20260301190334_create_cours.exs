defmodule Backend.Repo.Migrations.CreateCours do
  use Ecto.Migration

  def change do
    create table(:cours) do
      add :code, :string, null: false
      add :intitule, :string, null: false
      add :avancement_pct, :integer, default: 0, null: false
      add :semestre, :integer
      add :credits, :integer
      add :description, :text
      add :maj_avancement_le, :utc_datetime
      add :professeur_id, references(:professeurs, on_delete: :restrict), null: false
      timestamps(type: :utc_datetime)
    end

    create unique_index(:cours, [:code])
    create index(:cours, [:professeur_id])

    create constraint(:cours, :avancement_between_0_100,
             check: "avancement_pct >= 0 AND avancement_pct <= 100"
           )
  end
end
