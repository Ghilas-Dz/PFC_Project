defmodule Backend.Repo.Migrations.CreateUtilisateurs do
  use Ecto.Migration

  def change do
    create table(:utilisateurs) do
      add(:email_utilisateurs, :string)
      add(:mot_de_pass_utilisateurs, :string)
      add(:prenom_utilisateurs, :string)
      add(:nom_utilisateurs, :string)
      add(:avatar_utilisateurs, :string)
      add(:role_id, references(:roles, on_delete: :nilify_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:utilisateurs, [:role_id]))
    create(unique_index(:utilisateurs, [:email_utilisateurs]))
  end
end
