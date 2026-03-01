defmodule Backend.Repo.Migrations.CreateCommentaires do
  use Ecto.Migration

  def change do
    create table(:commentaires) do
      add :ticket_id, references(:tickets, on_delete: :delete_all), null: false
      add :auteur_id, references(:utilisateurs), null: false
      add :contenu, :text, null: false
      add :interne, :boolean, default: false, null: false
      timestamps(type: :utc_datetime)
    end

    create index(:commentaires, [:ticket_id])
    create index(:commentaires, [:auteur_id])
  end
end
