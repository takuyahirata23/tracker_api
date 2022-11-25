defmodule TrackerWeb.MobileUserSessionController do
  use TrackerWeb, :controller

  alias Tracker.Accounts

  def show(conn, attrs) do
    case Accounts.register_mobile_user(attrs) do
      {:ok, res} ->
        json(conn, res)

      {:error, res} ->
        json(conn, res)
    end

    # case Accounts.get_user_by_email_and_password(email, password) do
    #   nil ->
    #     json(conn, %{error: "user not found"})

    #   %User{} = user ->
    #     json(conn, %{user: user})
    # end
  end
end
