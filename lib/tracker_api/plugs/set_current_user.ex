defmodule Tracker.Plugs.SetCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, id} <- Tracker.Token.verify(token) do
      %{current_user: Tracker.Accounts.get_user!(id)}
    else
      _ ->
        %{current_user: nil}
    end
  end
end
