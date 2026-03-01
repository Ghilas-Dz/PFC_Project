defmodule Backend.Support.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :type, :string
    field :description, :string
    field :reference, :string
    field :portee, :string
    field :categorie, :string
    field :objet, :string
    field :statut, :string
    field :priorite, :string
    field :note_satisfaction, :integer
    field :resolu_le, :utc_datetime
    belongs_to :createur, Backend.Accounts.Etudiant, foreign_key: :createur_id
    belongs_to :groupe_concerne, Backend.Academics.Groupe, foreign_key: :groupe_concerne_id
    belongs_to :cours, Backend.Academics.Cours, foreign_key: :cours_id
    belongs_to :assigne_prof, Backend.Accounts.Professeur, foreign_key: :assigne_prof_id
    belongs_to :assigne_admin, Backend.Accounts.Administration, foreign_key: :assigne_admin_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [
      :reference,
      :portee,
      :type,
      :categorie,
      :objet,
      :description,
      :statut,
      :priorite,
      :note_satisfaction,
      :resolu_le,
      :createur_id,
      :groupe_concerne_id,
      :cours_id,
      :assigne_prof_id,
      :assigne_admin_id
    ])
    |> validate_required([
      :reference,
      :portee,
      :type,
      :categorie,
      :objet,
      :description,
      :statut,
      :priorite,
      :note_satisfaction,
      :resolu_le
    ])
    |> unique_constraint(:reference)
    |> foreign_key_constraint(:createur_id)
    |> foreign_key_constraint(:groupe_concerne_id)
    |> foreign_key_constraint(:cours_id)
    |> foreign_key_constraint(:assigne_prof_id)
    |> foreign_key_constraint(:assigne_admin_id)
  end
end
