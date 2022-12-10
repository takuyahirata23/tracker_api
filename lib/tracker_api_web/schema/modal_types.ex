defmodule TrackerWeb.Schema.ModalTypes do
  use Absinthe.Schema.Notation
  alias TrackerWeb.Resolvers.Vehicles

  object :modal do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  object :modal_queries do
    @desc "Get modals of specific make"
    field :modals, list_of(non_null(:modal)) do
      arg(:make_id, :string)
      resolve(&Vehicles.get_modals_by_make_id/3)
    end
  end
end
