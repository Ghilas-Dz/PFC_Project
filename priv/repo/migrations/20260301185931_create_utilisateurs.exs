defmodule Backend.Repo.Migrations.CreateUtilisateurs do
  use Ecto.Migration

  def change do
    create table(:utilisateurs) do
      add :email, :string, null: false
      add :mot_de_passe, :string, null: false
      add :prenom, :string, null: false
      add :nom, :string, null: false
      add :actif, :boolean, default: false, null: false
      add :avatar_url, :string
      add :derniere_connexion, :utc_datetime
      add :role_id, references(:roles, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:utilisateurs, [:email])
    create index(:utilisateurs, [:role_id])
  end
end
