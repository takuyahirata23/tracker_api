defmodule TrackerWeb.LiveHelpers do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def show_mobile_menu(js \\ %JS{}) do
    js
    |> JS.show(to: "#mobile-nav-overlay", display: "flex")
  end

  def close_mobile_menu(js \\ %JS{}) do
    js
    |> JS.hide(to: "#mobile-nav-overlay")
  end

  def show_sidebar(js \\ %JS{}) do
    js
    |> JS.show(to: "#sidebar-overlay")
    |> JS.show(
      to: "#sidebar",
      display: "flex",
      transition: {"ease-out duration-300", "translate-x-full", "translate-x-0"}
    )
  end

  def hide_sidebar(js \\ %JS{}) do
    js
    |> JS.hide(to: "#sidebar-overlay")
    |> JS.hide(
      to: "#sidebar",
      transition: {"ease-in duration-300", "translate-x-0", "translate-x-full"}
    )
  end

  attr :id, :string, required: true

  def modal(assigns) do
    ~H"""
    <div id={@id}>
      <div class="flex absolute inset-0 bg-primary/20 items-center justify-center z-50">
        <div class="bg-white p-8 rounded-md drop-shadow-sm w-11/12 lg:w-9/12 xl:w-7/12 max-w-7xl">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end
end
