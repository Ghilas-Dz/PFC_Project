defmodule Backend.SupportTest do
  use Backend.DataCase

  alias Backend.Support

  describe "tickets" do
    alias Backend.Support.Ticket

    import Backend.SupportFixtures

    @invalid_attrs %{portee_ticket: nil, referance_ticket: nil, type_ticket: nil, categorie_ticket: nil, object_ticket: nil, description_ticket: nil, statut_ticket: nil, priorite_ticket: nil, note_satisfaction_ticket: nil, cree_le_ticket: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Support.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Support.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{portee_ticket: "some portee_ticket", referance_ticket: "some referance_ticket", type_ticket: "some type_ticket", categorie_ticket: "some categorie_ticket", object_ticket: "some object_ticket", description_ticket: "some description_ticket", statut_ticket: "some statut_ticket", priorite_ticket: "some priorite_ticket", note_satisfaction_ticket: 42, cree_le_ticket: ~U[2026-03-10 19:02:00Z]}

      assert {:ok, %Ticket{} = ticket} = Support.create_ticket(valid_attrs)
      assert ticket.portee_ticket == "some portee_ticket"
      assert ticket.referance_ticket == "some referance_ticket"
      assert ticket.type_ticket == "some type_ticket"
      assert ticket.categorie_ticket == "some categorie_ticket"
      assert ticket.object_ticket == "some object_ticket"
      assert ticket.description_ticket == "some description_ticket"
      assert ticket.statut_ticket == "some statut_ticket"
      assert ticket.priorite_ticket == "some priorite_ticket"
      assert ticket.note_satisfaction_ticket == 42
      assert ticket.cree_le_ticket == ~U[2026-03-10 19:02:00Z]
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      update_attrs = %{portee_ticket: "some updated portee_ticket", referance_ticket: "some updated referance_ticket", type_ticket: "some updated type_ticket", categorie_ticket: "some updated categorie_ticket", object_ticket: "some updated object_ticket", description_ticket: "some updated description_ticket", statut_ticket: "some updated statut_ticket", priorite_ticket: "some updated priorite_ticket", note_satisfaction_ticket: 43, cree_le_ticket: ~U[2026-03-11 19:02:00Z]}

      assert {:ok, %Ticket{} = ticket} = Support.update_ticket(ticket, update_attrs)
      assert ticket.portee_ticket == "some updated portee_ticket"
      assert ticket.referance_ticket == "some updated referance_ticket"
      assert ticket.type_ticket == "some updated type_ticket"
      assert ticket.categorie_ticket == "some updated categorie_ticket"
      assert ticket.object_ticket == "some updated object_ticket"
      assert ticket.description_ticket == "some updated description_ticket"
      assert ticket.statut_ticket == "some updated statut_ticket"
      assert ticket.priorite_ticket == "some updated priorite_ticket"
      assert ticket.note_satisfaction_ticket == 43
      assert ticket.cree_le_ticket == ~U[2026-03-11 19:02:00Z]
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_ticket(ticket, @invalid_attrs)
      assert ticket == Support.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Support.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Support.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Support.change_ticket(ticket)
    end
  end

  describe "commentaires" do
    alias Backend.Support.Commentaire

    import Backend.SupportFixtures

    @invalid_attrs %{contenu_commentaires: nil, interne_commentaires: nil}

    test "list_commentaires/0 returns all commentaires" do
      commentaire = commentaire_fixture()
      assert Support.list_commentaires() == [commentaire]
    end

    test "get_commentaire!/1 returns the commentaire with given id" do
      commentaire = commentaire_fixture()
      assert Support.get_commentaire!(commentaire.id) == commentaire
    end

    test "create_commentaire/1 with valid data creates a commentaire" do
      valid_attrs = %{contenu_commentaires: "some contenu_commentaires", interne_commentaires: true}

      assert {:ok, %Commentaire{} = commentaire} = Support.create_commentaire(valid_attrs)
      assert commentaire.contenu_commentaires == "some contenu_commentaires"
      assert commentaire.interne_commentaires == true
    end

    test "create_commentaire/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_commentaire(@invalid_attrs)
    end

    test "update_commentaire/2 with valid data updates the commentaire" do
      commentaire = commentaire_fixture()
      update_attrs = %{contenu_commentaires: "some updated contenu_commentaires", interne_commentaires: false}

      assert {:ok, %Commentaire{} = commentaire} = Support.update_commentaire(commentaire, update_attrs)
      assert commentaire.contenu_commentaires == "some updated contenu_commentaires"
      assert commentaire.interne_commentaires == false
    end

    test "update_commentaire/2 with invalid data returns error changeset" do
      commentaire = commentaire_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_commentaire(commentaire, @invalid_attrs)
      assert commentaire == Support.get_commentaire!(commentaire.id)
    end

    test "delete_commentaire/1 deletes the commentaire" do
      commentaire = commentaire_fixture()
      assert {:ok, %Commentaire{}} = Support.delete_commentaire(commentaire)
      assert_raise Ecto.NoResultsError, fn -> Support.get_commentaire!(commentaire.id) end
    end

    test "change_commentaire/1 returns a commentaire changeset" do
      commentaire = commentaire_fixture()
      assert %Ecto.Changeset{} = Support.change_commentaire(commentaire)
    end
  end

  describe "notifications" do
    alias Backend.Support.Notification

    import Backend.SupportFixtures

    @invalid_attrs %{type_notifications: nil, message_notifications: nil, cree_le_notifications: nil, lien_notifications: nil}

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert Support.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert Support.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      valid_attrs = %{type_notifications: "some type_notifications", message_notifications: "some message_notifications", cree_le_notifications: ~U[2026-03-10 19:03:00Z], lien_notifications: "some lien_notifications"}

      assert {:ok, %Notification{} = notification} = Support.create_notification(valid_attrs)
      assert notification.type_notifications == "some type_notifications"
      assert notification.message_notifications == "some message_notifications"
      assert notification.cree_le_notifications == ~U[2026-03-10 19:03:00Z]
      assert notification.lien_notifications == "some lien_notifications"
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      update_attrs = %{type_notifications: "some updated type_notifications", message_notifications: "some updated message_notifications", cree_le_notifications: ~U[2026-03-11 19:03:00Z], lien_notifications: "some updated lien_notifications"}

      assert {:ok, %Notification{} = notification} = Support.update_notification(notification, update_attrs)
      assert notification.type_notifications == "some updated type_notifications"
      assert notification.message_notifications == "some updated message_notifications"
      assert notification.cree_le_notifications == ~U[2026-03-11 19:03:00Z]
      assert notification.lien_notifications == "some updated lien_notifications"
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_notification(notification, @invalid_attrs)
      assert notification == Support.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = Support.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> Support.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = Support.change_notification(notification)
    end
  end
end
