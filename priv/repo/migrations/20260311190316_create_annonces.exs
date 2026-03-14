defmodule Backend.Repo.Migrations.CreateAnnonces do
  use Ecto.Migration

  def change do
    create table(:annonces) do
      add :titre_annonce, :string
      add :contenu_annonce, :text
      add :date_publication_annonce, :utc_datetime
      add :utilisateur_id, references(:utilisateurs, on_delete: :nilify_all)

      timestamps(type: :utc_datetime)
    end

    create index(:annonces, [:utilisateur_id])
  end
end
