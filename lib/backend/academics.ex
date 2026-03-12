defmodule Backend.Academics do
  @moduledoc """
  The Academics context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Academics.Groupe

  @doc """
  Returns the list of groupes.

  ## Examples

      iex> list_groupes()
      [%Groupe{}, ...]

  """
  def list_groupes do
    Repo.all(Groupe)
  end

  @doc """
  Gets a single groupe.

  Raises `Ecto.NoResultsError` if the Groupe does not exist.

  ## Examples

      iex> get_groupe!(123)
      %Groupe{}

      iex> get_groupe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_groupe!(id), do: Repo.get!(Groupe, id)

  def get_groupe_by_name(name) do
    Repo.get_by(Groupe, libele_groupes: name)
  end

  @doc """
  Creates a groupe.

  ## Examples

      iex> create_groupe(%{field: value})
      {:ok, %Groupe{}}

      iex> create_groupe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_groupe(attrs \\ %{}) do
    %Groupe{}
    |> Groupe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a groupe.

  ## Examples

      iex> update_groupe(groupe, %{field: new_value})
      {:ok, %Groupe{}}

      iex> update_groupe(groupe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_groupe(%Groupe{} = groupe, attrs) do
    groupe
    |> Groupe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a groupe.

  ## Examples

      iex> delete_groupe(groupe)
      {:ok, %Groupe{}}

      iex> delete_groupe(groupe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_groupe(%Groupe{} = groupe) do
    Repo.delete(groupe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking groupe changes.

  ## Examples

      iex> change_groupe(groupe)
      %Ecto.Changeset{data: %Groupe{}}

  """
  def change_groupe(%Groupe{} = groupe, attrs \\ %{}) do
    Groupe.changeset(groupe, attrs)
  end

  alias Backend.Academics.Module

  @doc """
  Returns the list of module.

  ## Examples

      iex> list_module()
      [%Module{}, ...]

  """
  def list_module do
    Repo.all(Module)
  end

  @doc """
  Gets a single module.

  Raises `Ecto.NoResultsError` if the Module does not exist.

  ## Examples

      iex> get_module!(123)
      %Module{}

      iex> get_module!(456)
      ** (Ecto.NoResultsError)

  """
  def get_module!(id), do: Repo.get!(Module, id)

  @doc """
  Creates a module.

  ## Examples

      iex> create_module(%{field: value})
      {:ok, %Module{}}

      iex> create_module(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_module(attrs \\ %{}) do
    %Module{}
    |> Module.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a module.

  ## Examples

      iex> update_module(module, %{field: new_value})
      {:ok, %Module{}}

      iex> update_module(module, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_module(%Module{} = module, attrs) do
    module
    |> Module.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a module.

  ## Examples

      iex> delete_module(module)
      {:ok, %Module{}}

      iex> delete_module(module)
      {:error, %Ecto.Changeset{}}

  """
  def delete_module(%Module{} = module) do
    Repo.delete(module)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking module changes.

  ## Examples

      iex> change_module(module)
      %Ecto.Changeset{data: %Module{}}

  """
  def change_module(%Module{} = module, attrs \\ %{}) do
    Module.changeset(module, attrs)
  end

  alias Backend.Academics.Enseigner

  @doc """
  Returns the list of enseigner.

  ## Examples

      iex> list_enseigner()
      [%Enseigner{}, ...]

  """
  def list_enseigner do
    Repo.all(Enseigner)
  end

  @doc """
  Gets a single enseigner.

  Raises `Ecto.NoResultsError` if the Enseigner does not exist.

  ## Examples

      iex> get_enseigner!(123)
      %Enseigner{}

      iex> get_enseigner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enseigner!(id), do: Repo.get!(Enseigner, id)

  @doc """
  Creates a enseigner.

  ## Examples

      iex> create_enseigner(%{field: value})
      {:ok, %Enseigner{}}

      iex> create_enseigner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enseigner(attrs \\ %{}) do
    %Enseigner{}
    |> Enseigner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enseigner.

  ## Examples

      iex> update_enseigner(enseigner, %{field: new_value})
      {:ok, %Enseigner{}}

      iex> update_enseigner(enseigner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enseigner(%Enseigner{} = enseigner, attrs) do
    enseigner
    |> Enseigner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a enseigner.

  ## Examples

      iex> delete_enseigner(enseigner)
      {:ok, %Enseigner{}}

      iex> delete_enseigner(enseigner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enseigner(%Enseigner{} = enseigner) do
    Repo.delete(enseigner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enseigner changes.

  ## Examples

      iex> change_enseigner(enseigner)
      %Ecto.Changeset{data: %Enseigner{}}

  """
  def change_enseigner(%Enseigner{} = enseigner, attrs \\ %{}) do
    Enseigner.changeset(enseigner, attrs)
  end
end
