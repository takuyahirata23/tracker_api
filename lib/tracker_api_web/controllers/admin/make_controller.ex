defmodule TrackerWeb.Admin.MakeController do
  use TrackerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
