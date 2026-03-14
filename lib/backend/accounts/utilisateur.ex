defmodule Backend.Accounts.Utilisateur do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :email_utilisateurs,
             :prenom_utilisateurs,
             :nom_utilisateurs,
             :avatar_utilisateurs
           ]}
  schema "utilisateurs" do
    field(:email_utilisateurs, :string)
    field(:mot_de_pass_utilisateurs, :string, redact: true)
    field(:password, :string, virtual: true, redact: true)
    field(:prenom_utilisateurs, :string)
    field(:nom_utilisateurs, :string)
    field(:avatar_utilisateurs, :string)

    belongs_to(:role, Backend.Accounts.Role)

    has_one(:etudiant, Backend.Accounts.Etudiant)
    has_one(:professeur, Backend.Accounts.Professeur)
    has_one(:administration, Backend.Accounts.Administration)
    has_many(:tickets, Backend.Support.Ticket)
    has_many(:commentaires, Backend.Support.Commentaire)
    has_many(:notifications, Backend.Support.Notification)
    has_many(:annonces, Backend.Communication.Annonce)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(utilisateur, attrs) do
    utilisateur
    |> cast(attrs, [
      :email_utilisateurs,
      :password,
      :prenom_utilisateurs,
      :nom_utilisateurs,
      :avatar_utilisateurs,
      :role_id
    ])
    |> validate_required([
      :email_utilisateurs,
      :password,
      :prenom_utilisateurs,
      :nom_utilisateurs
    ])
    |> validate_change(:email_utilisateurs, fn :email_utilisateurs, email ->
      if String.ends_with?(email, "univ-bejaia.dz") do
        []
      else
        [email_utilisateurs: "Doit être un email universitaire valide"]
      end
    end)
    |> validate_length(:password, min: 6, message: "doit contenir au moins 6 caractères")
    |> unique_constraint(:email_utilisateurs)
    |> foreign_key_constraint(:role_id)
    |> hash_password()
  end

  @doc """
  Changeset for updates (password optional).
  """
  def update_changeset(utilisateur, attrs) do
    utilisateur
    |> cast(attrs, [
      :email_utilisateurs,
      :password,
      :prenom_utilisateurs,
      :nom_utilisateurs,
      :avatar_utilisateurs,
      :role_id
    ])
    |> validate_required([
      :email_utilisateurs,
      :prenom_utilisateurs,
      :nom_utilisateurs
    ])
    |> validate_format(:email_utilisateurs, ~r/^[^\s]+@[^\s]+$/,
      message: "doit être un email valide"
    )
    |> unique_constraint(:email_utilisateurs)
    |> foreign_key_constraint(:role_id)
    |> maybe_hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, mot_de_pass_utilisateurs: Bcrypt.hash_pwd_salt(password, log_rounds: 10))
  end

  defp hash_password(changeset), do: changeset

  defp maybe_hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset)
       when is_binary(password) do
    change(changeset, mot_de_pass_utilisateurs: Bcrypt.hash_pwd_salt(password, log_rounds: 10))
  end

  defp maybe_hash_password(changeset), do: changeset
end
