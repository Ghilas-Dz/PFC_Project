defmodule Backend.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :portee_ticket, :string
      add :referance_ticket, :string
      add :type_ticket, :string
      add :categorie_ticket, :string
      add :object_ticket, :string
      add :description_ticket, :text
      add :statut_ticket, :string
      add :priorite_ticket, :string
      add :note_satisfaction_ticket, :integer
      add :cree_le_ticket, :utc_datetime
      add :utilisateur_id, references(:utilisateurs, on_delete: :nilify_all)

      timestamps(type: :utc_datetime)
    end

    create index(:tickets, [:utilisateur_id])
    create unique_index(:tickets, [:referance_ticket])
  end
end
