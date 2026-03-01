defmodule Backend.Repo.Migrations.CreateAccesFonctionnalites do
  use Ecto.Migration

  def change do
    create table(:acces_fonctionnalites) do
      add :est_delegue, :boolean, default: false, null: false
      add :autorise, :boolean, default: false, null: false
      add :fonctionnalite_id, references(:fonctionnalites, on_delete: :delete_all), null: false
      add :role_id, references(:roles, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:acces_fonctionnalites, [:fonctionnalite_id])
    create index(:acces_fonctionnalites, [:role_id])
  end
end
