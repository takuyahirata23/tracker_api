defmodule TrackerWeb.Schema.MotorcycleTypes do
  use Absinthe.Schema.Notation
  alias TrackerWeb.Resolvers.Vehicles, as: VehicleResolver

  object :motorcycle do
    field :id, non_null(:id)
    field :make, non_null(:string)
    field :modal, non_null(:string)
    field :year, non_null(:integer)
  end

  input_object :motorcycle_input do
    field :make_id, non_null(:string)
    field :modal_id, non_null(:string)
    field :year, non_null(:integer)
  end

  object :motorcycle_queries do
    @desc "Get all of user's motorcycles"
    field :motorcycles, list_of(non_null(:motorcycle)) do
      resolve(&VehicleResolver.get_motorcycles/3)
    end
  end

  object :motorcycle_mutations do
    @desc "Register a motorcycle"
    field :register_motorcycle, type: non_null(:motorcycle) do
      arg(:motorcycle_input, non_null(:motorcycle_input))
      resolve(&VehicleResolver.register_motorcycle/3)
    end
  end
end
