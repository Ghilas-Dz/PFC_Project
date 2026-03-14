defmodule Backend.AccountsTest do
  use Backend.DataCase

  alias Backend.Accounts

  describe "roles" do
    alias Backend.Accounts.Role

    import Backend.AccountsFixtures

    @invalid_attrs %{nom_roles: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{nom_roles: "some nom_roles"}

      assert {:ok, %Role{} = role} = Accounts.create_role(valid_attrs)
      assert role.nom_roles == "some nom_roles"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{nom_roles: "some updated nom_roles"}

      assert {:ok, %Role{} = role} = Accounts.update_role(role, update_attrs)
      assert role.nom_roles == "some updated nom_roles"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
      assert role == Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Accounts.change_role(role)
    end
  end

  describe "utilisateurs" do
    alias Backend.Accounts.Utilisateur

    import Backend.AccountsFixtures

    @invalid_attrs %{email_utilisateurs: nil, mot_de_pass_utilisateurs: nil, prenom_utilisateurs: nil, nom_utilisateurs: nil, cree_le_utilisateurs: nil, actif_utilisateurs: nil, avatar_utilisateurs: nil}

    test "list_utilisateurs/0 returns all utilisateurs" do
      utilisateur = utilisateur_fixture()
      assert Accounts.list_utilisateurs() == [utilisateur]
    end

    test "get_utilisateur!/1 returns the utilisateur with given id" do
      utilisateur = utilisateur_fixture()
      assert Accounts.get_utilisateur!(utilisateur.id) == utilisateur
    end

    test "create_utilisateur/1 with valid data creates a utilisateur" do
      valid_attrs = %{email_utilisateurs: "some email_utilisateurs", mot_de_pass_utilisateurs: "some mot_de_pass_utilisateurs", prenom_utilisateurs: "some prenom_utilisateurs", nom_utilisateurs: "some nom_utilisateurs", cree_le_utilisateurs: ~U[2026-03-10 18:54:00Z], actif_utilisateurs: true, avatar_utilisateurs: "some avatar_utilisateurs"}

      assert {:ok, %Utilisateur{} = utilisateur} = Accounts.create_utilisateur(valid_attrs)
      assert utilisateur.email_utilisateurs == "some email_utilisateurs"
      assert utilisateur.mot_de_pass_utilisateurs == "some mot_de_pass_utilisateurs"
      assert utilisateur.prenom_utilisateurs == "some prenom_utilisateurs"
      assert utilisateur.nom_utilisateurs == "some nom_utilisateurs"
      assert utilisateur.cree_le_utilisateurs == ~U[2026-03-10 18:54:00Z]
      assert utilisateur.actif_utilisateurs == true
      assert utilisateur.avatar_utilisateurs == "some avatar_utilisateurs"
    end

    test "create_utilisateur/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_utilisateur(@invalid_attrs)
    end

    test "update_utilisateur/2 with valid data updates the utilisateur" do
      utilisateur = utilisateur_fixture()
      update_attrs = %{email_utilisateurs: "some updated email_utilisateurs", mot_de_pass_utilisateurs: "some updated mot_de_pass_utilisateurs", prenom_utilisateurs: "some updated prenom_utilisateurs", nom_utilisateurs: "some updated nom_utilisateurs", cree_le_utilisateurs: ~U[2026-03-11 18:54:00Z], actif_utilisateurs: false, avatar_utilisateurs: "some updated avatar_utilisateurs"}

      assert {:ok, %Utilisateur{} = utilisateur} = Accounts.update_utilisateur(utilisateur, update_attrs)
      assert utilisateur.email_utilisateurs == "some updated email_utilisateurs"
      assert utilisateur.mot_de_pass_utilisateurs == "some updated mot_de_pass_utilisateurs"
      assert utilisateur.prenom_utilisateurs == "some updated prenom_utilisateurs"
      assert utilisateur.nom_utilisateurs == "some updated nom_utilisateurs"
      assert utilisateur.cree_le_utilisateurs == ~U[2026-03-11 18:54:00Z]
      assert utilisateur.actif_utilisateurs == false
      assert utilisateur.avatar_utilisateurs == "some updated avatar_utilisateurs"
    end

    test "update_utilisateur/2 with invalid data returns error changeset" do
      utilisateur = utilisateur_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_utilisateur(utilisateur, @invalid_attrs)
      assert utilisateur == Accounts.get_utilisateur!(utilisateur.id)
    end

    test "delete_utilisateur/1 deletes the utilisateur" do
      utilisateur = utilisateur_fixture()
      assert {:ok, %Utilisateur{}} = Accounts.delete_utilisateur(utilisateur)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_utilisateur!(utilisateur.id) end
    end

    test "change_utilisateur/1 returns a utilisateur changeset" do
      utilisateur = utilisateur_fixture()
      assert %Ecto.Changeset{} = Accounts.change_utilisateur(utilisateur)
    end
  end

  describe "etudiants" do
    alias Backend.Accounts.Etudiant

    import Backend.AccountsFixtures

    @invalid_attrs %{est_delegue_etudiant: nil, date_naissance_etudiant: nil, telephone_etudiant: nil}

    test "list_etudiants/0 returns all etudiants" do
      etudiant = etudiant_fixture()
      assert Accounts.list_etudiants() == [etudiant]
    end

    test "get_etudiant!/1 returns the etudiant with given id" do
      etudiant = etudiant_fixture()
      assert Accounts.get_etudiant!(etudiant.id) == etudiant
    end

    test "create_etudiant/1 with valid data creates a etudiant" do
      valid_attrs = %{est_delegue_etudiant: true, date_naissance_etudiant: ~D[2026-03-10], telephone_etudiant: "some telephone_etudiant"}

      assert {:ok, %Etudiant{} = etudiant} = Accounts.create_etudiant(valid_attrs)
      assert etudiant.est_delegue_etudiant == true
      assert etudiant.date_naissance_etudiant == ~D[2026-03-10]
      assert etudiant.telephone_etudiant == "some telephone_etudiant"
    end

    test "create_etudiant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_etudiant(@invalid_attrs)
    end

    test "update_etudiant/2 with valid data updates the etudiant" do
      etudiant = etudiant_fixture()
      update_attrs = %{est_delegue_etudiant: false, date_naissance_etudiant: ~D[2026-03-11], telephone_etudiant: "some updated telephone_etudiant"}

      assert {:ok, %Etudiant{} = etudiant} = Accounts.update_etudiant(etudiant, update_attrs)
      assert etudiant.est_delegue_etudiant == false
      assert etudiant.date_naissance_etudiant == ~D[2026-03-11]
      assert etudiant.telephone_etudiant == "some updated telephone_etudiant"
    end

    test "update_etudiant/2 with invalid data returns error changeset" do
      etudiant = etudiant_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_etudiant(etudiant, @invalid_attrs)
      assert etudiant == Accounts.get_etudiant!(etudiant.id)
    end

    test "delete_etudiant/1 deletes the etudiant" do
      etudiant = etudiant_fixture()
      assert {:ok, %Etudiant{}} = Accounts.delete_etudiant(etudiant)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_etudiant!(etudiant.id) end
    end

    test "change_etudiant/1 returns a etudiant changeset" do
      etudiant = etudiant_fixture()
      assert %Ecto.Changeset{} = Accounts.change_etudiant(etudiant)
    end
  end

  describe "professeurs" do
    alias Backend.Accounts.Professeur

    import Backend.AccountsFixtures

    @invalid_attrs %{grade_professeurs: nil, telephone_professeurs: nil, specialite_professeurs: nil}

    test "list_professeurs/0 returns all professeurs" do
      professeur = professeur_fixture()
      assert Accounts.list_professeurs() == [professeur]
    end

    test "get_professeur!/1 returns the professeur with given id" do
      professeur = professeur_fixture()
      assert Accounts.get_professeur!(professeur.id) == professeur
    end

    test "create_professeur/1 with valid data creates a professeur" do
      valid_attrs = %{grade_professeurs: "some grade_professeurs", telephone_professeurs: "some telephone_professeurs", specialite_professeurs: "some specialite_professeurs"}

      assert {:ok, %Professeur{} = professeur} = Accounts.create_professeur(valid_attrs)
      assert professeur.grade_professeurs == "some grade_professeurs"
      assert professeur.telephone_professeurs == "some telephone_professeurs"
      assert professeur.specialite_professeurs == "some specialite_professeurs"
    end

    test "create_professeur/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_professeur(@invalid_attrs)
    end

    test "update_professeur/2 with valid data updates the professeur" do
      professeur = professeur_fixture()
      update_attrs = %{grade_professeurs: "some updated grade_professeurs", telephone_professeurs: "some updated telephone_professeurs", specialite_professeurs: "some updated specialite_professeurs"}

      assert {:ok, %Professeur{} = professeur} = Accounts.update_professeur(professeur, update_attrs)
      assert professeur.grade_professeurs == "some updated grade_professeurs"
      assert professeur.telephone_professeurs == "some updated telephone_professeurs"
      assert professeur.specialite_professeurs == "some updated specialite_professeurs"
    end

    test "update_professeur/2 with invalid data returns error changeset" do
      professeur = professeur_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_professeur(professeur, @invalid_attrs)
      assert professeur == Accounts.get_professeur!(professeur.id)
    end

    test "delete_professeur/1 deletes the professeur" do
      professeur = professeur_fixture()
      assert {:ok, %Professeur{}} = Accounts.delete_professeur(professeur)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_professeur!(professeur.id) end
    end

    test "change_professeur/1 returns a professeur changeset" do
      professeur = professeur_fixture()
      assert %Ecto.Changeset{} = Accounts.change_professeur(professeur)
    end
  end

  describe "administration" do
    alias Backend.Accounts.Administration

    import Backend.AccountsFixtures

    @invalid_attrs %{poste_administration: nil, departement_administration: nil, telephone_administration: nil}

    test "list_administration/0 returns all administration" do
      administration = administration_fixture()
      assert Accounts.list_administration() == [administration]
    end

    test "get_administration!/1 returns the administration with given id" do
      administration = administration_fixture()
      assert Accounts.get_administration!(administration.id) == administration
    end

    test "create_administration/1 with valid data creates a administration" do
      valid_attrs = %{poste_administration: "some poste_administration", departement_administration: "some departement_administration", telephone_administration: "some telephone_administration"}

      assert {:ok, %Administration{} = administration} = Accounts.create_administration(valid_attrs)
      assert administration.poste_administration == "some poste_administration"
      assert administration.departement_administration == "some departement_administration"
      assert administration.telephone_administration == "some telephone_administration"
    end

    test "create_administration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_administration(@invalid_attrs)
    end

    test "update_administration/2 with valid data updates the administration" do
      administration = administration_fixture()
      update_attrs = %{poste_administration: "some updated poste_administration", departement_administration: "some updated departement_administration", telephone_administration: "some updated telephone_administration"}

      assert {:ok, %Administration{} = administration} = Accounts.update_administration(administration, update_attrs)
      assert administration.poste_administration == "some updated poste_administration"
      assert administration.departement_administration == "some updated departement_administration"
      assert administration.telephone_administration == "some updated telephone_administration"
    end

    test "update_administration/2 with invalid data returns error changeset" do
      administration = administration_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_administration(administration, @invalid_attrs)
      assert administration == Accounts.get_administration!(administration.id)
    end

    test "delete_administration/1 deletes the administration" do
      administration = administration_fixture()
      assert {:ok, %Administration{}} = Accounts.delete_administration(administration)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_administration!(administration.id) end
    end

    test "change_administration/1 returns a administration changeset" do
      administration = administration_fixture()
      assert %Ecto.Changeset{} = Accounts.change_administration(administration)
    end
  end
end
