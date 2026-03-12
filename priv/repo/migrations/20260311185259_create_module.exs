defmodule Backend.Repo.Migrations.CreateModule do
  use Ecto.Migration

  def change do
    create table(:module) do
      add(:code_cours, :string)
      add(:intitule_cours, :string)
      add(:semestre_module, :string)
      add(:credits_module, :integer)
      add(:description_module, :text)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:module, [:code_cours]))
  end
end
