defmodule Backend.Repo.Migrations.CreateGroupes do
  use Ecto.Migration

  def change do
    create table(:groupes) do
      add :code, :string, null: false
      add :libelle, :string, null: false
      add :annee_academique, :string, null: false
      add :filiere, :string
      add :niveau, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:groupes, [:code])
  end
end
