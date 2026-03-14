defmodule Backend.CommunicationTest do
  use Backend.DataCase

  alias Backend.Communication

  describe "annonces" do
    alias Backend.Communication.Annonce

    import Backend.CommunicationFixtures

    @invalid_attrs %{titre_annonce: nil, contenu_annonce: nil, date_publication_annonce: nil}

    test "list_annonces/0 returns all annonces" do
      annonce = annonce_fixture()
      assert Communication.list_annonces() == [annonce]
    end

    test "get_annonce!/1 returns the annonce with given id" do
      annonce = annonce_fixture()
      assert Communication.get_annonce!(annonce.id) == annonce
    end

    test "create_annonce/1 with valid data creates a annonce" do
      valid_attrs = %{titre_annonce: "some titre_annonce", contenu_annonce: "some contenu_annonce", date_publication_annonce: ~U[2026-03-10 19:03:00Z]}

      assert {:ok, %Annonce{} = annonce} = Communication.create_annonce(valid_attrs)
      assert annonce.titre_annonce == "some titre_annonce"
      assert annonce.contenu_annonce == "some contenu_annonce"
      assert annonce.date_publication_annonce == ~U[2026-03-10 19:03:00Z]
    end

    test "create_annonce/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communication.create_annonce(@invalid_attrs)
    end

    test "update_annonce/2 with valid data updates the annonce" do
      annonce = annonce_fixture()
      update_attrs = %{titre_annonce: "some updated titre_annonce", contenu_annonce: "some updated contenu_annonce", date_publication_annonce: ~U[2026-03-11 19:03:00Z]}

      assert {:ok, %Annonce{} = annonce} = Communication.update_annonce(annonce, update_attrs)
      assert annonce.titre_annonce == "some updated titre_annonce"
      assert annonce.contenu_annonce == "some updated contenu_annonce"
      assert annonce.date_publication_annonce == ~U[2026-03-11 19:03:00Z]
    end

    test "update_annonce/2 with invalid data returns error changeset" do
      annonce = annonce_fixture()
      assert {:error, %Ecto.Changeset{}} = Communication.update_annonce(annonce, @invalid_attrs)
      assert annonce == Communication.get_annonce!(annonce.id)
    end

    test "delete_annonce/1 deletes the annonce" do
      annonce = annonce_fixture()
      assert {:ok, %Annonce{}} = Communication.delete_annonce(annonce)
      assert_raise Ecto.NoResultsError, fn -> Communication.get_annonce!(annonce.id) end
    end

    test "change_annonce/1 returns a annonce changeset" do
      annonce = annonce_fixture()
      assert %Ecto.Changeset{} = Communication.change_annonce(annonce)
    end
  end

  describe "souggestions" do
    alias Backend.Communication.Souggestion

    import Backend.CommunicationFixtures

    @invalid_attrs %{titre_souggestion: nil, contenu_souggestion: nil, like_souggestion: nil, dislike_souggestion: nil}

    test "list_souggestions/0 returns all souggestions" do
      souggestion = souggestion_fixture()
      assert Communication.list_souggestions() == [souggestion]
    end

    test "get_souggestion!/1 returns the souggestion with given id" do
      souggestion = souggestion_fixture()
      assert Communication.get_souggestion!(souggestion.id) == souggestion
    end

    test "create_souggestion/1 with valid data creates a souggestion" do
      valid_attrs = %{titre_souggestion: "some titre_souggestion", contenu_souggestion: "some contenu_souggestion", like_souggestion: 42, dislike_souggestion: 42}

      assert {:ok, %Souggestion{} = souggestion} = Communication.create_souggestion(valid_attrs)
      assert souggestion.titre_souggestion == "some titre_souggestion"
      assert souggestion.contenu_souggestion == "some contenu_souggestion"
      assert souggestion.like_souggestion == 42
      assert souggestion.dislike_souggestion == 42
    end

    test "create_souggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communication.create_souggestion(@invalid_attrs)
    end

    test "update_souggestion/2 with valid data updates the souggestion" do
      souggestion = souggestion_fixture()
      update_attrs = %{titre_souggestion: "some updated titre_souggestion", contenu_souggestion: "some updated contenu_souggestion", like_souggestion: 43, dislike_souggestion: 43}

      assert {:ok, %Souggestion{} = souggestion} = Communication.update_souggestion(souggestion, update_attrs)
      assert souggestion.titre_souggestion == "some updated titre_souggestion"
      assert souggestion.contenu_souggestion == "some updated contenu_souggestion"
      assert souggestion.like_souggestion == 43
      assert souggestion.dislike_souggestion == 43
    end

    test "update_souggestion/2 with invalid data returns error changeset" do
      souggestion = souggestion_fixture()
      assert {:error, %Ecto.Changeset{}} = Communication.update_souggestion(souggestion, @invalid_attrs)
      assert souggestion == Communication.get_souggestion!(souggestion.id)
    end

    test "delete_souggestion/1 deletes the souggestion" do
      souggestion = souggestion_fixture()
      assert {:ok, %Souggestion{}} = Communication.delete_souggestion(souggestion)
      assert_raise Ecto.NoResultsError, fn -> Communication.get_souggestion!(souggestion.id) end
    end

    test "change_souggestion/1 returns a souggestion changeset" do
      souggestion = souggestion_fixture()
      assert %Ecto.Changeset{} = Communication.change_souggestion(souggestion)
    end
  end
end
