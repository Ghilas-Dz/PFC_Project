defmodule Backend.AcademicsTest do
  use Backend.DataCase

  alias Backend.Academics

  describe "groupes" do
    alias Backend.Academics.Groupe

    import Backend.AcademicsFixtures

    @invalid_attrs %{code_groupes: nil, libele_groupes: nil, annee_academique_groupes: nil, filier_groupe: nil, niveau_groupe: nil}

    test "list_groupes/0 returns all groupes" do
      groupe = groupe_fixture()
      assert Academics.list_groupes() == [groupe]
    end

    test "get_groupe!/1 returns the groupe with given id" do
      groupe = groupe_fixture()
      assert Academics.get_groupe!(groupe.id) == groupe
    end

    test "create_groupe/1 with valid data creates a groupe" do
      valid_attrs = %{code_groupes: "some code_groupes", libele_groupes: "some libele_groupes", annee_academique_groupes: "some annee_academique_groupes", filier_groupe: "some filier_groupe", niveau_groupe: "some niveau_groupe"}

      assert {:ok, %Groupe{} = groupe} = Academics.create_groupe(valid_attrs)
      assert groupe.code_groupes == "some code_groupes"
      assert groupe.libele_groupes == "some libele_groupes"
      assert groupe.annee_academique_groupes == "some annee_academique_groupes"
      assert groupe.filier_groupe == "some filier_groupe"
      assert groupe.niveau_groupe == "some niveau_groupe"
    end

    test "create_groupe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Academics.create_groupe(@invalid_attrs)
    end

    test "update_groupe/2 with valid data updates the groupe" do
      groupe = groupe_fixture()
      update_attrs = %{code_groupes: "some updated code_groupes", libele_groupes: "some updated libele_groupes", annee_academique_groupes: "some updated annee_academique_groupes", filier_groupe: "some updated filier_groupe", niveau_groupe: "some updated niveau_groupe"}

      assert {:ok, %Groupe{} = groupe} = Academics.update_groupe(groupe, update_attrs)
      assert groupe.code_groupes == "some updated code_groupes"
      assert groupe.libele_groupes == "some updated libele_groupes"
      assert groupe.annee_academique_groupes == "some updated annee_academique_groupes"
      assert groupe.filier_groupe == "some updated filier_groupe"
      assert groupe.niveau_groupe == "some updated niveau_groupe"
    end

    test "update_groupe/2 with invalid data returns error changeset" do
      groupe = groupe_fixture()
      assert {:error, %Ecto.Changeset{}} = Academics.update_groupe(groupe, @invalid_attrs)
      assert groupe == Academics.get_groupe!(groupe.id)
    end

    test "delete_groupe/1 deletes the groupe" do
      groupe = groupe_fixture()
      assert {:ok, %Groupe{}} = Academics.delete_groupe(groupe)
      assert_raise Ecto.NoResultsError, fn -> Academics.get_groupe!(groupe.id) end
    end

    test "change_groupe/1 returns a groupe changeset" do
      groupe = groupe_fixture()
      assert %Ecto.Changeset{} = Academics.change_groupe(groupe)
    end
  end

  describe "module" do
    alias Backend.Academics.Module

    import Backend.AcademicsFixtures

    @invalid_attrs %{code_cours: nil, intitule_cours: nil, semestre_module: nil, credits_module: nil, description_module: nil}

    test "list_module/0 returns all module" do
      module = module_fixture()
      assert Academics.list_module() == [module]
    end

    test "get_module!/1 returns the module with given id" do
      module = module_fixture()
      assert Academics.get_module!(module.id) == module
    end

    test "create_module/1 with valid data creates a module" do
      valid_attrs = %{code_cours: "some code_cours", intitule_cours: "some intitule_cours", semestre_module: "some semestre_module", credits_module: 42, description_module: "some description_module"}

      assert {:ok, %Module{} = module} = Academics.create_module(valid_attrs)
      assert module.code_cours == "some code_cours"
      assert module.intitule_cours == "some intitule_cours"
      assert module.semestre_module == "some semestre_module"
      assert module.credits_module == 42
      assert module.description_module == "some description_module"
    end

    test "create_module/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Academics.create_module(@invalid_attrs)
    end

    test "update_module/2 with valid data updates the module" do
      module = module_fixture()
      update_attrs = %{code_cours: "some updated code_cours", intitule_cours: "some updated intitule_cours", semestre_module: "some updated semestre_module", credits_module: 43, description_module: "some updated description_module"}

      assert {:ok, %Module{} = module} = Academics.update_module(module, update_attrs)
      assert module.code_cours == "some updated code_cours"
      assert module.intitule_cours == "some updated intitule_cours"
      assert module.semestre_module == "some updated semestre_module"
      assert module.credits_module == 43
      assert module.description_module == "some updated description_module"
    end

    test "update_module/2 with invalid data returns error changeset" do
      module = module_fixture()
      assert {:error, %Ecto.Changeset{}} = Academics.update_module(module, @invalid_attrs)
      assert module == Academics.get_module!(module.id)
    end

    test "delete_module/1 deletes the module" do
      module = module_fixture()
      assert {:ok, %Module{}} = Academics.delete_module(module)
      assert_raise Ecto.NoResultsError, fn -> Academics.get_module!(module.id) end
    end

    test "change_module/1 returns a module changeset" do
      module = module_fixture()
      assert %Ecto.Changeset{} = Academics.change_module(module)
    end
  end

  describe "enseigner" do
    alias Backend.Academics.Enseigner

    import Backend.AcademicsFixtures

    @invalid_attrs %{annee_academique_enseigner: nil, semestre_enseigner: nil, date_debut_enseigner: nil, date_fin_enseigner: nil}

    test "list_enseigner/0 returns all enseigner" do
      enseigner = enseigner_fixture()
      assert Academics.list_enseigner() == [enseigner]
    end

    test "get_enseigner!/1 returns the enseigner with given id" do
      enseigner = enseigner_fixture()
      assert Academics.get_enseigner!(enseigner.id) == enseigner
    end

    test "create_enseigner/1 with valid data creates a enseigner" do
      valid_attrs = %{annee_academique_enseigner: "some annee_academique_enseigner", semestre_enseigner: "some semestre_enseigner", date_debut_enseigner: ~D[2026-03-10], date_fin_enseigner: ~D[2026-03-10]}

      assert {:ok, %Enseigner{} = enseigner} = Academics.create_enseigner(valid_attrs)
      assert enseigner.annee_academique_enseigner == "some annee_academique_enseigner"
      assert enseigner.semestre_enseigner == "some semestre_enseigner"
      assert enseigner.date_debut_enseigner == ~D[2026-03-10]
      assert enseigner.date_fin_enseigner == ~D[2026-03-10]
    end

    test "create_enseigner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Academics.create_enseigner(@invalid_attrs)
    end

    test "update_enseigner/2 with valid data updates the enseigner" do
      enseigner = enseigner_fixture()
      update_attrs = %{annee_academique_enseigner: "some updated annee_academique_enseigner", semestre_enseigner: "some updated semestre_enseigner", date_debut_enseigner: ~D[2026-03-11], date_fin_enseigner: ~D[2026-03-11]}

      assert {:ok, %Enseigner{} = enseigner} = Academics.update_enseigner(enseigner, update_attrs)
      assert enseigner.annee_academique_enseigner == "some updated annee_academique_enseigner"
      assert enseigner.semestre_enseigner == "some updated semestre_enseigner"
      assert enseigner.date_debut_enseigner == ~D[2026-03-11]
      assert enseigner.date_fin_enseigner == ~D[2026-03-11]
    end

    test "update_enseigner/2 with invalid data returns error changeset" do
      enseigner = enseigner_fixture()
      assert {:error, %Ecto.Changeset{}} = Academics.update_enseigner(enseigner, @invalid_attrs)
      assert enseigner == Academics.get_enseigner!(enseigner.id)
    end

    test "delete_enseigner/1 deletes the enseigner" do
      enseigner = enseigner_fixture()
      assert {:ok, %Enseigner{}} = Academics.delete_enseigner(enseigner)
      assert_raise Ecto.NoResultsError, fn -> Academics.get_enseigner!(enseigner.id) end
    end

    test "change_enseigner/1 returns a enseigner changeset" do
      enseigner = enseigner_fixture()
      assert %Ecto.Changeset{} = Academics.change_enseigner(enseigner)
    end
  end
end
