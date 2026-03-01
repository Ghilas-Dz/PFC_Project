defmodule Backend.Accounts do
  @moduledoc """
  The Accounts context.

  Fournit des fonctions CRUD pour `Utilisateur`, `Role`, `Professeur`,
  `Etudiant` et `Administration`.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Accounts.{Utilisateur, Role, Professeur, Etudiant, Administration}
  alias Backend.Academics.Groupe
  alias Backend.System.Notification
  alias Backend.Support.{Ticket, Commentaire, AuditLog}
  alias Backend.Delegation.DelegueAction
  alias Backend.Access.{Fonctionnalite, AccesFonctionnalite}
  alias Backend.Academics.Cours

  # Utilisateurs
  def list_utilisateurs do
    Repo.all(Utilisateur) |> Repo.preload(:role)
  end

  def get_utilisateur!(id), do: Repo.get!(Utilisateur, id) |> Repo.preload(:role)

  def get_utilisateur_by_email(email) do
    case Repo.get_by(Utilisateur, email: email) do
      nil -> nil
      user -> Repo.preload(user, :role)
    end
  end

  def create_utilisateur(attrs \\ %{}) do
    attrs_map = if is_map(attrs), do: attrs, else: Enum.into(attrs, %{})

    # accept incoming role as string under :role
    role_name = Map.get(attrs_map, :role) || Map.get(attrs_map, "role")
    attrs_clean = attrs_map |> Map.delete(:role) |> Map.delete("role")

    cond do
      is_binary(role_name) and role_name != "" ->
        role_name_trim = String.trim(role_name)

        case Repo.get_by(Role, nom: role_name_trim) do
          nil ->
            cs =
              Utilisateur.changeset(%Utilisateur{}, attrs_clean)
              |> Ecto.Changeset.add_error(:role, "role not found: #{role_name_trim}")

            {:error, cs}

          role ->
            role
            |> Ecto.build_assoc(:utilisateurs)
            |> Utilisateur.changeset(attrs_clean)
            |> Repo.insert()
        end

      true ->
        %Utilisateur{}
        |> Utilisateur.changeset(attrs_map)
        |> Repo.insert()
    end
  end

  def update_utilisateur(%Utilisateur{} = utilisateur, attrs) do
    utilisateur
    |> Utilisateur.changeset(attrs)
    |> Repo.update()
  end

  def delete_utilisateur(%Utilisateur{} = utilisateur) do
    Repo.delete(utilisateur)
  end

  def change_utilisateur(%Utilisateur{} = utilisateur, attrs \\ %{}) do
    Utilisateur.changeset(utilisateur, attrs)
  end

  # Roles
  def list_roles do
    Repo.all(Role)
  end

  def get_role!(id), do: Repo.get!(Role, id)

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  # Professeurs
  def list_professeurs do
    Repo.all(Professeur) |> Repo.preload(:utilisateur)
  end

  def get_professeur!(id), do: Repo.get!(Professeur, id) |> Repo.preload(:utilisateur)

  def get_professeur_by_matricule(matricule), do: Repo.get_by(Professeur, matricule: matricule)

  def get_professeur_by_matricule(matricule) do
    case Repo.get_by(Professeur, matricule: matricule) do
      nil -> nil
      prof -> Repo.preload(prof, :utilisateur)
    end
  end

  def create_professeur(attrs \\ %{}) do
    %Professeur{}
    |> Professeur.changeset(attrs)
    |> Repo.insert()
  end

  def update_professeur(%Professeur{} = professeur, attrs) do
    professeur
    |> Professeur.changeset(attrs)
    |> Repo.update()
  end

  def delete_professeur(%Professeur{} = professeur) do
    Repo.delete(professeur)
  end

  def change_professeur(%Professeur{} = professeur, attrs \\ %{}) do
    Professeur.changeset(professeur, attrs)
  end

  # Etudiants
  def list_etudiants do
    Repo.all(Etudiant) |> Repo.preload([:utilisateur, :groupe])
  end

  def get_etudiant!(id), do: Repo.get!(Etudiant, id) |> Repo.preload([:utilisateur, :groupe])

  def get_etudiant_by_numero(numero) do
    case Repo.get_by(Etudiant, numero_etudiant: numero) do
      nil -> nil
      e -> Repo.preload(e, [:utilisateur, :groupe])
    end
  end

  def get_etudiant_by_utilisateur(utilisateur_id) do
    case Repo.get_by(Etudiant, utilisateur_id: utilisateur_id) do
      nil -> nil
      e -> Repo.preload(e, [:utilisateur, :groupe])
    end
  end

  def create_etudiant(attrs \\ %{}) do
    attrs_map = if is_map(attrs), do: attrs, else: Enum.into(attrs, %{})
    attrs_map = normalize_keys_to_strings(attrs_map)

    groupe_val = Map.get(attrs_map, "groupe")
    attrs_clean = Map.delete(attrs_map, "groupe")

    if is_binary(groupe_val) and groupe_val != "" do
      groupe_code = String.trim(groupe_val)

      case Repo.get_by(Groupe, code: groupe_code) do
        nil ->
          cs =
            Etudiant.changeset(%Etudiant{}, attrs_clean)
            |> Ecto.Changeset.add_error(:groupe, "groupe not found: #{groupe_code}")

          {:error, cs}

        groupe ->
          attrs_with_groupe = Map.put(attrs_clean, "groupe_id", groupe.id)

          %Etudiant{}
          |> Etudiant.changeset(attrs_with_groupe)
          |> Repo.insert()
      end
    else
      %Etudiant{}
      |> Etudiant.changeset(attrs_map)
      |> Repo.insert()
    end
  end

  defp normalize_keys_to_strings(map) when is_map(map) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      key = if is_atom(k), do: Atom.to_string(k), else: k
      Map.put(acc, key, v)
    end)
  end

  def update_etudiant(%Etudiant{} = etudiant, attrs) do
    etudiant
    |> Etudiant.changeset(attrs)
    |> Repo.update()
  end

  def delete_etudiant(%Etudiant{} = etudiant) do
    Repo.delete(etudiant)
  end

  def change_etudiant(%Etudiant{} = etudiant, attrs \\ %{}) do
    Etudiant.changeset(etudiant, attrs)
  end

  # Administration
  def list_administrations do
    Repo.all(Administration) |> Repo.preload(:utilisateur)
  end

  def get_administration!(id), do: Repo.get!(Administration, id) |> Repo.preload(:utilisateur)

  def create_administration(attrs \\ %{}) do
    %Administration{}
    |> Administration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create an account composed of a `utilisateur` and an `etudiant` inside a transaction.
  Expects a map containing at least `"utilisateur"` and `"etudiant"` keys.
  Returns `{:ok, %{utilisateur: utilisateur, etudiant: etudiant}}` or `{:error, changeset}`.
  """
  def create_account_with_etudiant(
        %{
          "utilisateur" => utilisateur_params,
          "etudiant" => etudiant_params
        } = params
      ) do
    Repo.transaction(fn ->
      with {:ok, %Utilisateur{} = utilisateur} <- create_utilisateur(utilisateur_params) do
        utilisateur = Repo.preload(utilisateur, :role)

        etudiant_map =
          if is_map(etudiant_params), do: etudiant_params, else: Enum.into(etudiant_params, %{})

        # ajouter utilisateur_id
        etudiant_map = Map.put(etudiant_map, "utilisateur_id", utilisateur.id)

        # gérer le groupe
        groupe_val =
          Map.get(etudiant_map, "groupe") || Map.get(params, "groupe")

        etudiant_map =
          if is_binary(groupe_val) and groupe_val != "" do
            case Repo.get_by(Groupe, code: String.trim(groupe_val)) do
              nil ->
                cs =
                  Etudiant.changeset(%Etudiant{}, %{})
                  |> Ecto.Changeset.add_error(:groupe, "groupe not found: #{groupe_val}")

                Repo.rollback(cs)

              groupe ->
                Map.put(etudiant_map, "groupe_id", groupe.id)
            end
          else
            etudiant_map
          end

        case create_etudiant(etudiant_map) do
          {:ok, %Etudiant{} = etudiant} ->
            # Transformer les structs en maps simples
            etudiant_map_simple = %{
              id: etudiant.id,
              numero_etudiant: etudiant.numero_etudiant,
              est_delegue: etudiant.est_delegue,
              delegue_depuis: etudiant.delegue_depuis,
              date_naissance: etudiant.date_naissance,
              telephone: etudiant.telephone,
              utilisateur_id: etudiant.utilisateur_id,
              groupe_id: etudiant.groupe_id
            }

            utilisateur_map_simple = %{
              id: utilisateur.id,
              email: utilisateur.email,
              prenom: utilisateur.prenom,
              nom: utilisateur.nom,
              role: %{name: utilisateur.role.nom},
              avatar_url: utilisateur.avatar_url
            }

            # Retourner un map simple pour show/1
            %{utilisateur: utilisateur_map_simple, etudiant: etudiant_map_simple}

          {:error, changeset} ->
            Repo.rollback(changeset)
        end
      else
        {:error, changeset} -> Repo.rollback(changeset)
      end
    end)
  end

  def create_account_with_etudiant(_), do: {:error, :invalid_payload}

  def update_administration(%Administration{} = administration, attrs) do
    administration
    |> Administration.changeset(attrs)
    |> Repo.update()
  end

  def delete_administration(%Administration{} = administration) do
    Repo.delete(administration)
  end

  def change_administration(%Administration{} = administration, attrs \\ %{}) do
    Administration.changeset(administration, attrs)
  end

  # Notifications
  def list_notifications do
    Repo.all(Notification)
  end

  def get_notification!(id), do: Repo.get!(Notification, id)

  def create_notification(attrs \\ %{}) do
    %Notification{}
    |> Notification.changeset(attrs)
    |> Repo.insert()
  end

  def update_notification(%Notification{} = notification, attrs) do
    notification
    |> Notification.changeset(attrs)
    |> Repo.update()
  end

  def delete_notification(%Notification{} = notification) do
    Repo.delete(notification)
  end

  def change_notification(%Notification{} = notification, attrs \\ %{}) do
    Notification.changeset(notification, attrs)
  end

  # Tickets
  def list_tickets do
    Repo.all(Ticket)
  end

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  def change_ticket(%Ticket{} = ticket, attrs \\ %{}) do
    Ticket.changeset(ticket, attrs)
  end

  # Commentaires
  def list_commentaires do
    Repo.all(Commentaire)
  end

  def get_commentaire!(id), do: Repo.get!(Commentaire, id)

  def create_commentaire(attrs \\ %{}) do
    %Commentaire{}
    |> Commentaire.changeset(attrs)
    |> Repo.insert()
  end

  def update_commentaire(%Commentaire{} = commentaire, attrs) do
    commentaire
    |> Commentaire.changeset(attrs)
    |> Repo.update()
  end

  def delete_commentaire(%Commentaire{} = commentaire) do
    Repo.delete(commentaire)
  end

  def change_commentaire(%Commentaire{} = commentaire, attrs \\ %{}) do
    Commentaire.changeset(commentaire, attrs)
  end

  # AuditLogs
  def list_audit_logs do
    Repo.all(AuditLog)
  end

  def get_audit_log!(id), do: Repo.get!(AuditLog, id)

  def create_audit_log(attrs \\ %{}) do
    %AuditLog{}
    |> AuditLog.changeset(attrs)
    |> Repo.insert()
  end

  def update_audit_log(%AuditLog{} = audit_log, attrs) do
    audit_log
    |> AuditLog.changeset(attrs)
    |> Repo.update()
  end

  def delete_audit_log(%AuditLog{} = audit_log) do
    Repo.delete(audit_log)
  end

  def change_audit_log(%AuditLog{} = audit_log, attrs \\ %{}) do
    AuditLog.changeset(audit_log, attrs)
  end

  # DelegueActions
  def list_delegue_actions do
    Repo.all(DelegueAction)
  end

  def get_delegue_action!(id), do: Repo.get!(DelegueAction, id)

  def create_delegue_action(attrs \\ %{}) do
    %DelegueAction{}
    |> DelegueAction.changeset(attrs)
    |> Repo.insert()
  end

  def update_delegue_action(%DelegueAction{} = da, attrs) do
    da
    |> DelegueAction.changeset(attrs)
    |> Repo.update()
  end

  def delete_delegue_action(%DelegueAction{} = da) do
    Repo.delete(da)
  end

  def change_delegue_action(%DelegueAction{} = da, attrs \\ %{}) do
    DelegueAction.changeset(da, attrs)
  end

  # Fonctionnalites
  def list_fonctionnalites do
    Repo.all(Fonctionnalite)
  end

  def get_fonctionnalite!(id), do: Repo.get!(Fonctionnalite, id)

  def create_fonctionnalite(attrs \\ %{}) do
    %Fonctionnalite{}
    |> Fonctionnalite.changeset(attrs)
    |> Repo.insert()
  end

  def update_fonctionnalite(%Fonctionnalite{} = f, attrs) do
    f
    |> Fonctionnalite.changeset(attrs)
    |> Repo.update()
  end

  def delete_fonctionnalite(%Fonctionnalite{} = f) do
    Repo.delete(f)
  end

  def change_fonctionnalite(%Fonctionnalite{} = f, attrs \\ %{}) do
    Fonctionnalite.changeset(f, attrs)
  end

  # AccesFonctionnalites
  def list_acces_fonctionnalites do
    Repo.all(AccesFonctionnalite)
  end

  def get_acces_fonctionnalite!(id), do: Repo.get!(AccesFonctionnalite, id)

  def create_acces_fonctionnalite(attrs \\ %{}) do
    %AccesFonctionnalite{}
    |> AccesFonctionnalite.changeset(attrs)
    |> Repo.insert()
  end

  def update_acces_fonctionnalite(%AccesFonctionnalite{} = a, attrs) do
    a
    |> AccesFonctionnalite.changeset(attrs)
    |> Repo.update()
  end

  def delete_acces_fonctionnalite(%AccesFonctionnalite{} = a) do
    Repo.delete(a)
  end

  def change_acces_fonctionnalite(%AccesFonctionnalite{} = a, attrs \\ %{}) do
    AccesFonctionnalite.changeset(a, attrs)
  end

  # Groupes
  def list_groupes do
    Repo.all(Groupe)
  end

  def get_groupe!(id), do: Repo.get!(Groupe, id)

  def create_groupe(attrs \\ %{}) do
    %Groupe{}
    |> Groupe.changeset(attrs)
    |> Repo.insert()
  end

  def update_groupe(%Groupe{} = g, attrs) do
    g
    |> Groupe.changeset(attrs)
    |> Repo.update()
  end

  def delete_groupe(%Groupe{} = g) do
    Repo.delete(g)
  end

  def change_groupe(%Groupe{} = g, attrs \\ %{}) do
    Groupe.changeset(g, attrs)
  end

  # Cours
  def list_cours do
    Repo.all(Cours)
  end

  def get_cours!(id), do: Repo.get!(Cours, id)

  def create_cours(attrs \\ %{}) do
    %Cours{}
    |> Cours.changeset(attrs)
    |> Repo.insert()
  end

  def update_cours(%Cours{} = c, attrs) do
    c
    |> Cours.changeset(attrs)
    |> Repo.update()
  end

  def delete_cours(%Cours{} = c) do
    Repo.delete(c)
  end

  def change_cours(%Cours{} = c, attrs \\ %{}) do
    Cours.changeset(c, attrs)
  end
end
