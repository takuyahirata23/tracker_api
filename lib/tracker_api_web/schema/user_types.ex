defmodule Tracker.Schema.UserTypes do
  use Absinthe.Schema.Notation

  alias TrackerWeb.Resolvers.Accounts

  object :user do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  object :user_queries do
    @desc "Get current user"
    field :user, non_null(:user) do
      resolve(&Accounts.get_user/3)
    end
  end
end
