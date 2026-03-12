defmodule Backend.Repo.Migrations.CreateProfesseurs do
  use Ecto.Migration

  def change do
    create table(:professeurs) do
      add :grade_professeurs, :string
      add :telephone_professeurs, :string
      add :specialite_professeurs, :string
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:professeurs, [:utilisateur_id])
  end
end
