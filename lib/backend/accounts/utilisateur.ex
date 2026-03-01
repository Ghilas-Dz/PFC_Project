defmodule Backend.Accounts.Utilisateur do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "utilisateurs" do
    field :email, :string
    field :mot_de_passe, :string
    field :prenom, :string
    field :nom, :string
    field :actif, :boolean, default: false
    field :avatar_url, :string
    field :derniere_connexion, :utc_datetime
    belongs_to :role, Backend.Accounts.Role, foreign_key: :role_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(utilisateur, attrs) do
    utilisateur
    |> cast(attrs, [
      :email,
      :mot_de_passe,
      :prenom,
      :nom,
      :actif,
      :avatar_url,
      :derniere_connexion,
      :role_id
    ])
    |> validate_required([
      :email,
      :mot_de_passe,
      :prenom,
      :nom,
      :actif,
      :avatar_url,
      :derniere_connexion,
      :role_id
    ])
    |> foreign_key_constraint(:role_id)
    |> validate_change(:email, fn :email, email ->
      if String.ends_with?(email, ".univ-bejaia.dz") do
        []
      else
        [email: "Doit être un email universitaire valide"]
      end
    end)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  # Hash le mot de passe seulement si présent
  defp put_password_hash(changeset) do
    case get_change(changeset, :mot_de_passe) do
      nil -> changeset
      password -> put_change(changeset, :mot_de_passe, Bcrypt.hash_pwd_salt(password))
    end
  end
end
