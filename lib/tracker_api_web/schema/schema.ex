defmodule TrackerWeb.Schema.Schema do
  use Absinthe.Schema

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

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

    field :modals, list_of(:modal), resolve: dataloader(Vehicle)
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
      resolve(&Vehicles.get_makes/3)
    end
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(Tracker.Repo)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Vehicle, source)

    ctx = Map.put(ctx, :loader, loader)
    ctx
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
