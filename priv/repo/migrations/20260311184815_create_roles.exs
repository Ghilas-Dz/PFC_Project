defmodule Backend.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add(:nom_roles, :string)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:roles, [:nom_roles]))
  end
end
