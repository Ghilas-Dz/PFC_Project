defmodule Backend.Academics.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "module" do
    field(:code_cours, :string)
    field(:intitule_cours, :string)
    field(:semestre_module, :string)
    field(:credits_module, :integer)
    field(:description_module, :string)

    many_to_many(:professeurs, Backend.Accounts.Professeur, join_through: "enseigner")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [
      :code_cours,
      :intitule_cours,
      :semestre_module,
      :credits_module,
      :description_module
    ])
    |> validate_required([:code_cours, :intitule_cours, :semestre_module, :credits_module])
    |> unique_constraint(:code_cours)
  end
end
