defmodule Backend.Repo.Migrations.CreateFonctionnalites do
  use Ecto.Migration

  def change do
    create table(:fonctionnalites) do
      add :code, :string, null: false
      add :libelle, :string
      add :description, :text, null: false
      add :dashboard, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:fonctionnalites, [:code])
  end
end
