defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :auth do
    plug(BackendWeb.Auth.Pipeline)
    plug(BackendWeb.Auth.SetAccount)
  end

  scope "/api", BackendWeb do
    pipe_through(:api)

    post("/etudiant/register", AccountController, :create_etudiant)
    post("/professeur/register", AccountController, :create_professeur)
    post("/login", AccountController, :login)
  end

  scope "/api/auth/etudiant", BackendWeb do
    pipe_through([:api, :auth])
  end

  scope "/api/auth/professeur", BackendWeb do
    pipe_through([:api, :auth])
  end

  scope "/api/auth/admin", BackendWeb do
    pipe_through([:api, :auth])
  end

  scope "/api/auth", BackendWeb do
    pipe_through([:api, :auth])

    post("/accounts/update", AccountController, :update)
    delete("/sign_out", AccountController, :sign_out)
    get("/sign_out", AccountController, :sign_out)
    post("/accounts/refresh", AccountController, :refresh_session)
    get("/accounts/refresh", AccountController, :refresh_session)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:backend, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: BackendWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
