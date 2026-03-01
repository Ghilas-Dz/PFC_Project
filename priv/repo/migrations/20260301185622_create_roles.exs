defmodule Backend.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :nom, :string, null: false
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:roles, [:nom])
  end
end
