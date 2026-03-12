defmodule Backend.Repo.Migrations.CreateSouggestions do
  use Ecto.Migration

  def change do
    create table(:souggestions) do
      add :titre_souggestion, :string
      add :contenu_souggestion, :text
      add :like_souggestion, :integer
      add :dislike_souggestion, :integer
      add :etudiant_id, references(:etudiants, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:souggestions, [:etudiant_id])
  end
end
