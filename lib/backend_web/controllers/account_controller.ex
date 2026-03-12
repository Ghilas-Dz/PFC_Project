defmodule BackendWeb.AccountController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Accounts.Utilisateur
  alias BackendWeb.Auth.Guardian
  plug(:is_authorized when action in [:update, :delete])

  action_fallback(BackendWeb.FallbackController)

  defp is_authorized(conn, _opt) do
    %{params: %{"account" => params}} = conn
    utilisateur = Accounts.get_utilisateur!(params["id"])

    if conn.assigns.account.id == utilisateur.id do
      conn
    else
      raise(BackendWeb.Auth.ErrorResponse.Forbidden)
    end
  end

  def create_etudiant(conn, %{"account" => account_params}) do
    with {:ok, %Utilisateur{} = utilisateur} <- Accounts.create_utilisateur(account_params),
         {:ok, _etudiant} <-
           Accounts.create_etudiant(account_params, utilisateur.id) do
      authorize_user(conn, account_params["email_utilisateurs"], account_params["password"])
    end
  end

  def create_professeur(conn, %{"account" => account_params}) do
    with {:ok, %Utilisateur{} = utilisateur} <- Accounts.create_utilisateur(account_params),
         {:ok, _professeur} <-
           Accounts.create_professeur(account_params, utilisateur.id) do
      authorize_user(conn, account_params["email_utilisateurs"], account_params["password"])
    end
  end

  def refresh_session(conn, %{}) do
    with token when is_binary(token) <- Guardian.Plug.current_token(conn),
         {:ok, utilisateur, new_token} <- Guardian.authenticate(token) do
      conn
      |> Plug.Conn.put_session(:id, utilisateur.id)
      |> put_status(:ok)
      |> render(:show, utilisateur: utilisateur, token: new_token)
    else
      _ ->
        {:error, :invalid_credentials, message: "Session invalide ou expirée"}
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    authorize_user(conn, email, password)
  end

  defp authorize_user(conn, email, password) do
    with {:ok, utilisateur, token} <- Guardian.authenticate_user(email, password) do
      conn
      |> put_status(:ok)
      |> render(:show, utilisateur: utilisateur, token: token)
    end
  end

  def update(conn, %{"account" => account_params}) do
    utilisateur = Accounts.get_utilisateur!(account_params["id"])

    with {:ok, %Utilisateur{} = updated_utilisateur} <-
           Accounts.update_utilisateur(utilisateur, account_params) do
      conn
      |> put_status(:ok)
      |> render(:show_update, utilisateur: updated_utilisateur)
    end
  end

  def sign_out(conn, _params) do
    with token when is_binary(token) <- Guardian.Plug.current_token(conn),
         {:ok, _claims} <- Guardian.revoke(token) do
      conn
      |> Plug.Conn.clear_session()
      |> put_status(:ok)
      |> json(%{message: "Déconnexion réussie"})
    else
      _ ->
        {:error, :invalid_credentials, message: "Token invalide ou déjà révoqué"}
    end
  end
end
