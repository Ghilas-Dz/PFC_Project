defmodule Backend.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :type, :string, null: false
      add :message, :string, null: false
      add :lien, :string
      add :lue, :boolean, default: false, null: false
      add :destinataire_id, references(:utilisateurs, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:notifications, [:destinataire_id])
  end
end
