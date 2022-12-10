defmodule TrackerWeb.Schema.MakeTypes do
  use Absinthe.Schema.Notation
  alias TrackerWeb.Resolvers.Vehicles

  object :make do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  object :make_queries do
    @desc "Get all makes"
    field :makes, list_of(non_null(:make)) do
      resolve(&Vehicles.get_makes/3)
    end
  end
end
