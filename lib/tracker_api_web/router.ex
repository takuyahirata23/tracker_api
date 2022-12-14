defmodule TrackerWeb.Router do
  use TrackerWeb, :router

  import TrackerWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TrackerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :set_current_user do
    plug Tracker.Plugs.SetCurrentUser
  end

  pipeline :require_current_user do
    plug Tracker.Plugs.RequireCurrentUser
  end

  pipeline :require_admin_user do
    plug Tracker.Plugs.RequireAdminUser
  end

  scope "/", TrackerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TrackerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TrackerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", TrackerWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", TrackerWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/admin", TrackerWeb do
    pipe_through [:browser, :require_authenticated_user, :require_admin_user]

    live "/", DashboardLive, :index
    live "/makes", MakeLive, :index
    live "/makes/new", MakeLive, :new
    live "/makes/:make_id", MakeDetailLive, :show
    live "/makes/:make_id/new", MakeDetailLive, :new
    live "/tracks", TrackLive, :index
    live "/tracks/new", TrackLive, :new
  end

  scope "/", TrackerWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end

  scope "/" do
    pipe_through [:api, :set_current_user]

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TrackerWeb.Schema.Schema
  end

  scope "/" do
    pipe_through [:api, :set_current_user, :require_current_user]
    forward "/api", Absinthe.Plug, schema: TrackerWeb.Schema.Schema
  end

  scope "/", TrackerWeb do
    pipe_through [:api]

    post "/register", MobileUserSessionController, :register
    post "/login", MobileUserSessionController, :login
  end
end
