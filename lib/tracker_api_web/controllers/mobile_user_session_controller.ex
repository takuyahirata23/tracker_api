defmodule TrackerWeb.MobileUserSessionController do
  use TrackerWeb, :controller

  alias Tracker.Accounts

  def register(conn, attrs) do
    case Accounts.register_mobile_user(attrs) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("registraion.json", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> render("invalid_form.json", changeset: changeset)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.login_mobile_user(email, password) do
      {:ok, user} ->
        conn
        |> put_status(200)
        |> render("user.json", user: user)

      {:error} ->
        conn
        |> put_status(400)
        |> render("not_found.json", user: nil)
    end
  end
end
