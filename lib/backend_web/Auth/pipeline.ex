defmodule BackendWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :app,
    module: AppWeb.Auth.Guardian,
    error_handler: AppWeb.Auth.ErrorHandler

  plug(Guardian.Plug.VerifySession)
  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
