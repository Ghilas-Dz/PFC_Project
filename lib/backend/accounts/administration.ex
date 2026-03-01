defmodule Backend.Accounts.Administration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "administration" do
    field :poste, :string
    field :departement, :string
    field :telephone, :string
    belongs_to :utilisateur, Backend.Accounts.Utilisateur, foreign_key: :utilisateur_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(administration, attrs) do
    administration
    |> cast(attrs, [:poste, :departement, :telephone, :utilisateur_id])
    |> validate_required([:poste, :departement, :telephone, :utilisateur_id])
    |> foreign_key_constraint(:utilisateur_id)
  end
end
