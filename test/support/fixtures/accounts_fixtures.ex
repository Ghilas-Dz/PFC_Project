defmodule Backend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Accounts` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        nom_roles: "some nom_roles"
      })
      |> Backend.Accounts.create_role()

    role
  end

  @doc """
  Generate a utilisateur.
  """
  def utilisateur_fixture(attrs \\ %{}) do
    {:ok, utilisateur} =
      attrs
      |> Enum.into(%{
        actif_utilisateurs: true,
        avatar_utilisateurs: "some avatar_utilisateurs",
        cree_le_utilisateurs: ~U[2026-03-10 18:54:00Z],
        email_utilisateurs: "some email_utilisateurs",
        mot_de_pass_utilisateurs: "some mot_de_pass_utilisateurs",
        nom_utilisateurs: "some nom_utilisateurs",
        prenom_utilisateurs: "some prenom_utilisateurs"
      })
      |> Backend.Accounts.create_utilisateur()

    utilisateur
  end

  @doc """
  Generate a etudiant.
  """
  def etudiant_fixture(attrs \\ %{}) do
    {:ok, etudiant} =
      attrs
      |> Enum.into(%{
        date_naissance_etudiant: ~D[2026-03-10],
        est_delegue_etudiant: true,
        telephone_etudiant: "some telephone_etudiant"
      })
      |> Backend.Accounts.create_etudiant()

    etudiant
  end

  @doc """
  Generate a professeur.
  """
  def professeur_fixture(attrs \\ %{}) do
    {:ok, professeur} =
      attrs
      |> Enum.into(%{
        grade_professeurs: "some grade_professeurs",
        specialite_professeurs: "some specialite_professeurs",
        telephone_professeurs: "some telephone_professeurs"
      })
      |> Backend.Accounts.create_professeur()

    professeur
  end

  @doc """
  Generate a administration.
  """
  def administration_fixture(attrs \\ %{}) do
    {:ok, administration} =
      attrs
      |> Enum.into(%{
        departement_administration: "some departement_administration",
        poste_administration: "some poste_administration",
        telephone_administration: "some telephone_administration"
      })
      |> Backend.Accounts.create_administration()

    administration
  end
end
