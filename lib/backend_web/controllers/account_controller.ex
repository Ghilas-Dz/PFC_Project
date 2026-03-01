defmodule BackendWeb.AccountController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Accounts.Account
  alias Backend.Accounts.Utilisateur
  alias BackendWeb.Auth.Guardian
  plug :is_authorized when action in [:update, :delete]

  action_fallback(BackendWeb.FallbackController)

  defp is_authorized(conn, _opt) do
    %{params: %{"account" => params}} = conn
    account = Accounts.get_account!(params["id"])

    if conn.assigns.account.id == account.id do
      conn
    else
      raise(BackendWeb.Auth.ErrorResponse.Forbidden)
    end
  end

  def create(conn, %{"type" => "etudiant"} = params) do
    %{
      "type" => type,
      "utilisateur" => utilisateur,
      "etudiant" => etudiant
    } = params

    case Accounts.create_account_with_etudiant(%{
           "utilisateur" => utilisateur,
           "etudiant" => etudiant
         }) do
      {:ok, account_map} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(account_map[:utilisateur])

        conn
        |> put_status(:created)
        |> render(:show, Map.put(account_map, :token, token))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BackendWeb.ChangesetView, "error.json", changeset: changeset)

      {:error, :invalid_payload} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "invalid payload"})
    end
  end

  def login(conn, %{"email" => email, "mot_de_passe" => mot_de_passe}) do
    case Guardian.authenticate_user(email, mot_de_passe) do
      {:ok, %Utilisateur{} = account, token} ->
        etudiant = Accounts.get_etudiant_by_utilisateur(account.id)

        conn
        |> put_status(:ok)
        |> render(:show, %{utilisateur: account, etudiant: etudiant, token: token})

      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "invalid credentials"})
    end
  end
end
