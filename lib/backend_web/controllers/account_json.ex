defmodule BackendWeb.AccountJSON do
  def show(%{utilisateur: utilisateur, token: token}) do
    %{
      id: utilisateur.id,
      email_utilisateurs: utilisateur.email_utilisateurs,
      prenom_utilisateurs: utilisateur.prenom_utilisateurs,
      nom_utilisateurs: utilisateur.nom_utilisateurs,
      avatar_utilisateurs: utilisateur.avatar_utilisateurs,
      role: utilisateur.role.nom_roles,
      token: token
    }
  end

  def show_update(%{utilisateur: utilisateur}) do
    %{
      id: utilisateur.id,
      email_utilisateurs: utilisateur.email_utilisateurs,
      prenom_utilisateurs: utilisateur.prenom_utilisateurs,
      nom_utilisateurs: utilisateur.nom_utilisateurs,
      avatar_utilisateurs: utilisateur.avatar_utilisateurs
    }
  end
end
