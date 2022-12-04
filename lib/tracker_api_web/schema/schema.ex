defmodule TrackerWeb.Schema.Schema do
  use Absinthe.Schema

  alias TrackerWeb.Resolvers.Accounts

  query do
    @desc "Get list of users"
    field :user, non_null(:user) do
      resolve(&Accounts.get_user/3)
    end
  end

  object :user do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  # add more values to context here
  # def context(ctx) do
  #   ctx
  # end
end
