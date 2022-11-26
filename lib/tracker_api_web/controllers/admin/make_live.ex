defmodule TrackerWeb.MakeLive do
  use TrackerWeb, :live_view

  alias Tracker.Vehicle

  def mount(_params, _session, socket) do
    makes = Vehicle.get_makes()
    {:ok, assign(socket, makes: makes)}
  end
end
