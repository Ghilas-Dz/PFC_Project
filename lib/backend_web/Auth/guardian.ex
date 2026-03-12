defmodule BackendWeb.Auth.Guardian do
  use Guardian, otp_app: :backend

  alias Backend.Accounts
  alias Backend.Repo

  def subject_for_token(utilisateur, _claims) do
    {:ok, to_string(utilisateur.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    try do
      utilisateur =
        id
        |> Accounts.get_utilisateur!()
        |> Repo.preload(:role)

      {:ok, utilisateur}
    rescue
      Ecto.NoResultsError -> {:error, :resource_not_found}
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, utilisateur} <- resource_from_claims(claims),
         {:ok, _old, {new_token, _claims}} <- refresh(token) do
      {:ok, utilisateur, new_token}
    end
  end

  def authenticate_user(email, password) do
    case Accounts.get_utilisateur_by_email(email) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials, message: "Email ou mot de passe incorrect"}

      utilisateur ->
        if Bcrypt.verify_pass(password, utilisateur.mot_de_pass_utilisateurs) do
          generate_token(utilisateur, :access)
        else
          {:error, :invalid_credentials, message: "Email ou mot de passe incorrect"}
        end
    end
  end

  def generate_token(utilisateur, type) do
    {:ok, token, _claims} =
      __MODULE__.encode_and_sign(utilisateur, %{}, token_option(type))

    {:ok, utilisateur, token}
  end

  def token_option(type) do
    case type do
      :access -> [token_type: "access", ttl: {1, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {90, :day}]
    end
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
