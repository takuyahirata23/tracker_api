defmodule TrackerWeb.Resolvers.Accounts do
  alias Tracker.Accounts

  def get_users(_, _, _) do
    {:ok, Accounts.get_users()}
  end
end
