defmodule Backend.AcademicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Academics` context.
  """

  @doc """
  Generate a groupe.
  """
  def groupe_fixture(attrs \\ %{}) do
    {:ok, groupe} =
      attrs
      |> Enum.into(%{
        annee_academique_groupes: "some annee_academique_groupes",
        code_groupes: "some code_groupes",
        filier_groupe: "some filier_groupe",
        libele_groupes: "some libele_groupes",
        niveau_groupe: "some niveau_groupe"
      })
      |> Backend.Academics.create_groupe()

    groupe
  end

  @doc """
  Generate a module.
  """
  def module_fixture(attrs \\ %{}) do
    {:ok, module} =
      attrs
      |> Enum.into(%{
        code_cours: "some code_cours",
        credits_module: 42,
        description_module: "some description_module",
        intitule_cours: "some intitule_cours",
        semestre_module: "some semestre_module"
      })
      |> Backend.Academics.create_module()

    module
  end

  @doc """
  Generate a enseigner.
  """
  def enseigner_fixture(attrs \\ %{}) do
    {:ok, enseigner} =
      attrs
      |> Enum.into(%{
        annee_academique_enseigner: "some annee_academique_enseigner",
        date_debut_enseigner: ~D[2026-03-10],
        date_fin_enseigner: ~D[2026-03-10],
        semestre_enseigner: "some semestre_enseigner"
      })
      |> Backend.Academics.create_enseigner()

    enseigner
  end
end
