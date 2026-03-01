defmodule Backend.Academics.Cours do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cours" do
    field :code, :string
    field :description, :string
    field :intitule, :string
    field :avancement_pct, :integer
    field :semestre, :integer
    field :credits, :integer
    field :maj_avancement_le, :utc_datetime
    belongs_to :professeur, Backend.Accounts.Professeur, foreign_key: :professeur_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(cours, attrs) do
    cours
    |> cast(attrs, [
      :code,
      :intitule,
      :avancement_pct,
      :semestre,
      :credits,
      :description,
      :maj_avancement_le,
      :professeur_id
    ])
    |> validate_required([
      :code,
      :intitule,
      :avancement_pct,
      :semestre,
      :credits,
      :description,
      :maj_avancement_le
    ])
    |> foreign_key_constraint(:professeur_id)
    |> unique_constraint(:code)
  end
end
