defmodule TrackerWeb.Schema.Schema do
  use Absinthe.Schema

  alias TrackerWeb.Resolvers.{
    Accounts,
    Vehicles
  }

  object :user do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  object :make do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :modals, list_of(:modal)
  end

  object :modal do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  query do
    @desc "Get current user"
    field :user, non_null(:user) do
      resolve(&Accounts.get_user/3)
    end

    @desc "Get makes and their modals"
    field :vehicles, list_of(non_null(:make)) do
      resolve(&Vehicles.get_vehicles/3)
    end
  end

  # add more values to context here
  # def context(ctx) do
  #   ctx
  # end
end
