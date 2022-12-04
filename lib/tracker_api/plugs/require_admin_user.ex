defmodule Tracker.Plugs.RequireAdminUser do
  def init(opts), do: opts

  def call(conn, _ops) do
    case conn.assigns.current_user.is_admin do
      false ->
        conn
        |> Phoenix.Controller.redirect(to: "/")

      true ->
        conn
    end
  end
end
