defmodule TrackerWeb.LoginController do
  use TrackerWeb, :controller

  alias Tracker.Accounts

  def show(conn, %{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email_and_password(email, password)

    json(conn, %{user: user, token: "yo"})

    # case Accounts.get_user_by_email_and_password(email, password) do
    #   nil ->
    #     json(conn, %{error: "user not found"})

    #   %User{} = user ->
    #     json(conn, %{user: user})
    # end
  end
end
