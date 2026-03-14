defmodule Backend.Accounts.Administration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "administration" do
    field(:poste_administration, :string)
    field(:departement_administration, :string)
    field(:telephone_administration, :string)
    belongs_to(:utilisateur, Backend.Accounts.Utilisateur)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(administration, attrs) do
    administration
    |> cast(attrs, [:poste_administration, :departement_administration, :telephone_administration, :utilisateur_id])
    |> validate_required([
      :poste_administration,
      :departement_administration,
      :telephone_administration,
      :utilisateur_id
    ])
    |> unique_constraint(:utilisateur_id)
    |> foreign_key_constraint(:utilisateur_id)
  end
end
