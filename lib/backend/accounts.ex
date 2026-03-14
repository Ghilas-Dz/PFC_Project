defmodule Backend.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Accounts.Role
  alias Backend.Academics

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  def get_role_by_name(name) do
    Repo.get_by(Role, nom_roles: name)
  end

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias Backend.Accounts.Utilisateur

  @doc """
  Returns the list of utilisateurs.

  ## Examples

      iex> list_utilisateurs()
      [%Utilisateur{}, ...]

  """
  def list_utilisateurs do
    Repo.all(Utilisateur)
  end

  @doc """
  Gets a single utilisateur.

  Raises `Ecto.NoResultsError` if the Utilisateur does not exist.

  ## Examples

      iex> get_utilisateur!(123)
      %Utilisateur{}

      iex> get_utilisateur!(456)
      ** (Ecto.NoResultsError)

  """
  def get_utilisateur!(id), do: Repo.get!(Utilisateur, id)

  @doc """
  Gets a single utilisateur by email.

  Returns nil if no utilisateur found.
  """
  def get_utilisateur_by_email(email) do
    Repo.get_by(Utilisateur, email_utilisateurs: email)
    |> Repo.preload(:role)
  end

  @doc """
  Creates a utilisateur.

  ## Examples

      iex> create_utilisateur(%{field: value})
      {:ok, %Utilisateur{}}

      iex> create_utilisateur(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_utilisateur(attrs) do
    Repo.transaction(fn ->
      role_name = Map.get(attrs, :role) || Map.get(attrs, "role")

      case get_role_by_name(role_name) do
        nil ->
          # rollback avec raison
          Repo.rollback("Role is required")

        role ->
          case role
               |> Ecto.build_assoc(:utilisateurs)
               |> Utilisateur.changeset(attrs)
               |> Repo.insert() do
            {:ok, utilisateur} -> utilisateur
            {:error, changeset} -> Repo.rollback(changeset)
          end
      end
    end)
  end

  @doc """
  Updates a utilisateur.

  ## Examples

      iex> update_utilisateur(utilisateur, %{field: new_value})
      {:ok, %Utilisateur{}}

      iex> update_utilisateur(utilisateur, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_utilisateur(%Utilisateur{} = utilisateur, attrs) do
    utilisateur
    |> Utilisateur.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a utilisateur.

  ## Examples

      iex> delete_utilisateur(utilisateur)
      {:ok, %Utilisateur{}}

      iex> delete_utilisateur(utilisateur)
      {:error, %Ecto.Changeset{}}

  """
  def delete_utilisateur(%Utilisateur{} = utilisateur) do
    Repo.delete(utilisateur)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking utilisateur changes.

  ## Examples

      iex> change_utilisateur(utilisateur)
      %Ecto.Changeset{data: %Utilisateur{}}

  """
  def change_utilisateur(%Utilisateur{} = utilisateur, attrs \\ %{}) do
    Utilisateur.changeset(utilisateur, attrs)
  end

  alias Backend.Accounts.Etudiant

  @doc """
  Returns the list of etudiants.

  ## Examples

      iex> list_etudiants()
      [%Etudiant{}, ...]

  """
  def list_etudiants do
    Repo.all(Etudiant)
  end

  @doc """
  Gets a single etudiant.

  Raises `Ecto.NoResultsError` if the Etudiant does not exist.

  ## Examples

      iex> get_etudiant!(123)
      %Etudiant{}

      iex> get_etudiant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_etudiant!(id), do: Repo.get!(Etudiant, id)

  @doc """
  Creates a etudiant.

  ## Examples

      iex> create_etudiant(%{field: value})
      {:ok, %Etudiant{}}

      iex> create_etudiant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_etudiant(attrs, user_id) do
    groupe_name = Map.get(attrs, :groupe) || Map.get(attrs, "groupe")

    # Ajouter utilisateur_id et enlever la clé :groupe
    attrs =
      attrs
      |> Map.put(:utilisateur_id, user_id)
      |> Map.delete(:groupe)
      |> Enum.into(%{}, fn {k, v} -> {String.to_atom(to_string(k)), v} end)

    Repo.transaction(fn ->
      case Academics.get_groupe_by_name(groupe_name) do
        nil ->
          Repo.rollback("Groupe is required")

        groupe ->
          # Créer l'étudiant associé au groupe
          groupe
          |> Ecto.build_assoc(:etudiants)
          |> Etudiant.changeset(attrs)
          |> Repo.insert()
          |> case do
            # transaction continue / succès
            {:ok, etudiant} -> etudiant
            # rollback si erreurs du changeset
            {:error, changeset} -> Repo.rollback(changeset)
          end
      end
    end)
  end

  @doc """
  Updates a etudiant.

  ## Examples

      iex> update_etudiant(etudiant, %{field: new_value})
      {:ok, %Etudiant{}}

      iex> update_etudiant(etudiant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_etudiant(%Etudiant{} = etudiant, attrs) do
    etudiant
    |> Etudiant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a etudiant.

  ## Examples

      iex> delete_etudiant(etudiant)
      {:ok, %Etudiant{}}

      iex> delete_etudiant(etudiant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_etudiant(%Etudiant{} = etudiant) do
    Repo.delete(etudiant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking etudiant changes.

  ## Examples

      iex> change_etudiant(etudiant)
      %Ecto.Changeset{data: %Etudiant{}}

  """
  def change_etudiant(%Etudiant{} = etudiant, attrs \\ %{}) do
    Etudiant.changeset(etudiant, attrs)
  end

  alias Backend.Accounts.Professeur

  @doc """
  Returns the list of professeurs.

  ## Examples

      iex> list_professeurs()
      [%Professeur{}, ...]

  """
  def list_professeurs do
    Repo.all(Professeur)
  end

  @doc """
  Gets a single professeur.

  Raises `Ecto.NoResultsError` if the Professeur does not exist.

  ## Examples

      iex> get_professeur!(123)
      %Professeur{}

      iex> get_professeur!(456)
      ** (Ecto.NoResultsError)

  """
  def get_professeur!(id), do: Repo.get!(Professeur, id)

  @doc """
  Creates a professeur.

  ## Examples

      iex> create_professeur(%{field: value})
      {:ok, %Professeur{}}

      iex> create_professeur(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_professeur(attrs, user_id) do
    attrs =
      attrs
      |> Map.put(:utilisateur_id, user_id)
      |> Enum.into(%{}, fn {k, v} -> {String.to_atom(to_string(k)), v} end)

    Repo.transaction(fn ->
      case Professeur.changeset(%Professeur{}, attrs) |> Repo.insert() do
        {:ok, professeur} -> professeur
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  @doc """
  Updates a professeur.

  ## Examples

      iex> update_professeur(professeur, %{field: new_value})
      {:ok, %Professeur{}}

      iex> update_professeur(professeur, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_professeur(%Professeur{} = professeur, attrs) do
    professeur
    |> Professeur.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a professeur.

  ## Examples

      iex> delete_professeur(professeur)
      {:ok, %Professeur{}}

      iex> delete_professeur(professeur)
      {:error, %Ecto.Changeset{}}

  """
  def delete_professeur(%Professeur{} = professeur) do
    Repo.delete(professeur)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking professeur changes.

  ## Examples

      iex> change_professeur(professeur)
      %Ecto.Changeset{data: %Professeur{}}

  """
  def change_professeur(%Professeur{} = professeur, attrs \\ %{}) do
    Professeur.changeset(professeur, attrs)
  end

  alias Backend.Accounts.Administration

  @doc """
  Returns the list of administration.

  ## Examples

      iex> list_administration()
      [%Administration{}, ...]

  """
  def list_administration do
    Repo.all(Administration)
  end

  @doc """
  Gets a single administration.

  Raises `Ecto.NoResultsError` if the Administration does not exist.

  ## Examples

      iex> get_administration!(123)
      %Administration{}

      iex> get_administration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_administration!(id), do: Repo.get!(Administration, id)

  @doc """
  Creates a administration.

  ## Examples

      iex> create_administration(%{field: value})
      {:ok, %Administration{}}

      iex> create_administration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_administration(attrs \\ %{}) do
    %Administration{}
    |> Administration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a administration.

  ## Examples

      iex> update_administration(administration, %{field: new_value})
      {:ok, %Administration{}}

      iex> update_administration(administration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_administration(%Administration{} = administration, attrs) do
    administration
    |> Administration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a administration.

  ## Examples

      iex> delete_administration(administration)
      {:ok, %Administration{}}

      iex> delete_administration(administration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_administration(%Administration{} = administration) do
    Repo.delete(administration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking administration changes.

  ## Examples

      iex> change_administration(administration)
      %Ecto.Changeset{data: %Administration{}}

  """
  def change_administration(%Administration{} = administration, attrs \\ %{}) do
    Administration.changeset(administration, attrs)
  end
end
