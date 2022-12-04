defmodule TrackerWeb.Resolvers.Accounts do
  def get_user(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end
end
