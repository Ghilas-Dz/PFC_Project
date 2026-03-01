defmodule Backend.Repo.Migrations.CreateAdministration do
  use Ecto.Migration

  def change do
    create table(:administration) do
      add :poste, :string
      add :departement, :string
      add :telephone, :string
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:administration, [:utilisateur_id])
  end
end
