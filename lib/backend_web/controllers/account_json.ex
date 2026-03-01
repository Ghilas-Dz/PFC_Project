defmodule BackendWeb.AccountJSON do
  alias Backend.Accounts.{Utilisateur, Etudiant, Role}

  def show(%{utilisateur: utilisateur, etudiant: etudiant, token: token}) do
    %{
      utilisateur: utilisateur_to_map(utilisateur),
      etudiant: etudiant_to_map(etudiant),
      token: token
    }
  end

  defp utilisateur_to_map(nil), do: nil
  defp utilisateur_to_map(%{} = m) when not is_struct(m), do: m

  defp utilisateur_to_map(%Utilisateur{} = u) do
    %{
      id: u.id,
      email: u.email,
      prenom: u.prenom,
      nom: u.nom,
      role: role_to_map(u.role),
      avatar_url: u.avatar_url
    }
  end

  defp etudiant_to_map(nil), do: nil
  defp etudiant_to_map(%{} = m) when not is_struct(m), do: m

  defp etudiant_to_map(%Etudiant{} = e) do
    %{
      id: e.id,
      numero_etudiant: e.numero_etudiant,
      est_delegue: e.est_delegue,
      delegue_depuis: e.delegue_depuis,
      date_naissance: e.date_naissance,
      telephone: e.telephone,
      utilisateur_id: e.utilisateur_id,
      groupe_id: e.groupe_id
    }
  end

  defp role_to_map(nil), do: nil
  defp role_to_map(%{} = m) when not is_struct(m), do: m
  defp role_to_map(%Role{} = r), do: %{name: r.nom}

  def show(%{utilisateur: account, token: token}) do
    %{
      utilisateur: account,
      token: token
    }
  end
end
