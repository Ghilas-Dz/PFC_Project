defmodule BackendWeb.Auth.Guardian do
  use Guardian, otp_app: :backend

  alias Backend.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]

    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def authenticate_user(email, password) do
    case Accounts.get_account_by_email(email) do
      nil ->
        {:error, :invalid_credentials}

      account ->
        if Bcrypt.verify_pass(password, account.password_hash) do
          generate_token(account)
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def generate_token(account) do
    {:ok, token, _claims} = __MODULE__.encode_and_sign(account)
    {:ok, account, token}
  end

  # def after_encode_and_sign(resource, claims, token, _options) do
  #   with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
  #     {:ok, token}
  #   end
  # end

  # def on_verify(claims, token, _options) do
  # with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
  #  {:ok, claims}
  # end
  # end

  # def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
  # with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
  #  {:ok, {old_token, old_claims}, {new_token, new_claims}}
  # end
  # end

  # def on_revoke(claims, token, _options) do
  # with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
  # {:ok, claims}
  # end
  # end
end
