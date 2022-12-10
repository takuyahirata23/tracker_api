defmodule TrackerWeb.Schema.Schema do
  use Absinthe.Schema

  alias TrackerWeb.Schema

  import_types(Schema.UserTypes)
  import_types(Schema.MakeTypes)
  import_types(Schema.ModalTypes)
  import_types(Schema.MotorcycleTypes)

  query do
    import_fields(:user_queries)
    import_fields(:make_queries)
    import_fields(:modal_queries)
    import_fields(:motorcycle_queries)
  end

  mutation do
    import_fields(:motorcycle_mutations)
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
