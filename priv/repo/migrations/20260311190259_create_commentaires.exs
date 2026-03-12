defmodule Backend.Repo.Migrations.CreateCommentaires do
  use Ecto.Migration

  def change do
    create table(:commentaires) do
      add :contenu_commentaires, :text
      add :interne_commentaires, :boolean, default: false, null: false
      add :ticket_id, references(:tickets, on_delete: :delete_all)
      add :utilisateur_id, references(:utilisateurs, on_delete: :nilify_all)

      timestamps(type: :utc_datetime)
    end

    create index(:commentaires, [:ticket_id])
    create index(:commentaires, [:utilisateur_id])
  end
end
