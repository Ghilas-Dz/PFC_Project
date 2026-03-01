defmodule Backend.Access.AccesFonctionnalite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "acces_fonctionnalites" do
    field :est_delegue, :boolean, default: false
    field :autorise, :boolean, default: false
    belongs_to :fonctionnalite, Backend.Access.Fonctionnalite, foreign_key: :fonctionnalite_id
    belongs_to :role, Backend.Accounts.Role, foreign_key: :role_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(acces_fonctionnalite, attrs) do
    acces_fonctionnalite
    |> cast(attrs, [:est_delegue, :autorise, :fonctionnalite_id, :role_id])
    |> validate_required([:est_delegue, :autorise, :fonctionnalite_id, :role_id])
    |> foreign_key_constraint(:fonctionnalite_id)
    |> foreign_key_constraint(:role_id)
  end
end
