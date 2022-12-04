defmodule TrackerWeb.MobileUserSessionController do
  use TrackerWeb, :controller

  alias Tracker.Accounts

  def register(conn, attrs) do
    case Accounts.register_mobile_user(attrs) do
      {:ok, %{user: user, token: token}} ->
        conn
        |> put_status(201)
        |> render("registraion.json", user: user, token: token)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> render("invalid_form.json", changeset: changeset)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.login_mobile_user(email, password) do
      {:ok, %{user: user, token: token}} ->
        conn
        |> put_status(200)
        |> render("login.json", user: user, token: token)

      {:error} ->
        conn
        |> put_status(400)
        |> render("not_found.json", user: nil)
    end
  end
end
