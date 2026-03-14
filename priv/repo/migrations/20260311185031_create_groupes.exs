defmodule Backend.Repo.Migrations.CreateGroupes do
  use Ecto.Migration

  def change do
    create table(:groupes) do
      add(:code_groupes, :string)
      add(:libele_groupes, :string)
      add(:annee_academique_groupes, :string)
      add(:filier_groupe, :string)
      add(:niveau_groupe, :string)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:groupes, [:code_groupes]))
  end
end
