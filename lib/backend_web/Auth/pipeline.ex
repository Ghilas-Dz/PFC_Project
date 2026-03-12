defmodule BackendWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :backend,
    module: BackendWeb.Auth.Guardian,
    error_handler: BackendWeb.Auth.Errorhandler

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
