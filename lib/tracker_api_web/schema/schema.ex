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
    field :make, non_null(:make), resolve: dataloader(Vehicle)
  end

  object :user_vehicle do
    field :id, non_null(:id)
    field :make, non_null(:string)
    field :modal, non_null(:string)
    field :year, non_null(:integer)
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

    @desc "Get modals of specific make"
    field :modals, list_of(non_null(:modal)) do
      arg(:make_id, :string)
      resolve(&Vehicles.get_modals_by_make_id/3)
    end

    @desc "Get user vehicles"
    field :user_vehicles, list_of(non_null(:user_vehicle)) do
      resolve(&Vehicles.get_user_vehicles/3)
    end
  end

  mutation do
    @desc "Register a vihcile to user"
    field :register_user_vehicle, type: non_null(:user_vehicle) do
      arg(:year, non_null(:integer))
      arg(:modal_id, non_null(:string))
      arg(:make_id, non_null(:string))

      resolve(&Vehicles.register_user_vehicle/3)
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
