defmodule Backend.Repo.Migrations.CreateAdministration do
  use Ecto.Migration

  def change do
    create table(:administration) do
      add :poste_administration, :string
      add :departement_administration, :string
      add :telephone_administration, :string
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:administration, [:utilisateur_id])
  end
end
