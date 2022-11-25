defmodule Tracker.Plugs.RequireCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case conn.private[:absinthe].context.current_user do
      nil ->
        body = Jason.encode!(%{error: "not authenticated"})
        send_resp(conn, 401, body)

      _ ->
        conn
    end
  end
end
