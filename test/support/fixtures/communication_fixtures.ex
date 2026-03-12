defmodule Backend.CommunicationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Communication` context.
  """

  @doc """
  Generate a annonce.
  """
  def annonce_fixture(attrs \\ %{}) do
    {:ok, annonce} =
      attrs
      |> Enum.into(%{
        contenu_annonce: "some contenu_annonce",
        date_publication_annonce: ~U[2026-03-10 19:03:00Z],
        titre_annonce: "some titre_annonce"
      })
      |> Backend.Communication.create_annonce()

    annonce
  end

  @doc """
  Generate a souggestion.
  """
  def souggestion_fixture(attrs \\ %{}) do
    {:ok, souggestion} =
      attrs
      |> Enum.into(%{
        contenu_souggestion: "some contenu_souggestion",
        dislike_souggestion: 42,
        like_souggestion: 42,
        titre_souggestion: "some titre_souggestion"
      })
      |> Backend.Communication.create_souggestion()

    souggestion
  end
end
