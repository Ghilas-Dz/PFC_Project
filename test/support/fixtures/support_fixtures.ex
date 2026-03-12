defmodule Backend.SupportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Support` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        categorie_ticket: "some categorie_ticket",
        cree_le_ticket: ~U[2026-03-10 19:02:00Z],
        description_ticket: "some description_ticket",
        note_satisfaction_ticket: 42,
        object_ticket: "some object_ticket",
        portee_ticket: "some portee_ticket",
        priorite_ticket: "some priorite_ticket",
        referance_ticket: "some referance_ticket",
        statut_ticket: "some statut_ticket",
        type_ticket: "some type_ticket"
      })
      |> Backend.Support.create_ticket()

    ticket
  end

  @doc """
  Generate a commentaire.
  """
  def commentaire_fixture(attrs \\ %{}) do
    {:ok, commentaire} =
      attrs
      |> Enum.into(%{
        contenu_commentaires: "some contenu_commentaires",
        interne_commentaires: true
      })
      |> Backend.Support.create_commentaire()

    commentaire
  end

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        cree_le_notifications: ~U[2026-03-10 19:03:00Z],
        lien_notifications: "some lien_notifications",
        message_notifications: "some message_notifications",
        type_notifications: "some type_notifications"
      })
      |> Backend.Support.create_notification()

    notification
  end
end
