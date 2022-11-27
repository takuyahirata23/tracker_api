defmodule TrackerWeb.LiveHelpers do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  def show_mobile_menu(js \\ %JS{}) do
    js
    |> JS.show(
      to: "#mobile-nav-overlay",
      display: "flex",
      transition: {"ease-out duration-200", "opacity-0", "opacity-100"}
    )
  end

  def close_mobile_menu(js \\ %JS{}) do
    js
    |> JS.hide(to: "#mobile-nav-overlay")
  end

  def modal(assigns) do
    ~H"""
    <div>
      <div class="flex items-center justify-center absolute inset-0 bg-white/20 z-30">
        <div class="bg-bg-secondary p-4 rounded-md drop-shadow-md w-2/3">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def submit_button(assigns) do
    ~H"""
    <button type="submit" class="rounded-md px-2 py-1 bg-btn-primary text-secondary  w-full text-center">
      Submit
    </button>
    """
  end

  def patch_link(assigns) do
    assigns = assign_new(assigns, :secondary, fn -> false end)

    ~H"""
    <%= if @secondary do %>
      <%= live_patch [to: @patch, class: "py-1 px-2 bg-btn-secondary text-secondary rounded-md text-center w-full"] do%>
        <%= render_slot(@inner_block) %>
      <% end %>
    <% else %>
      <%= live_patch [to: @patch, class: "py-1 px-2 bg-btn-primary text-secondary rounded-md block w-full text-center"] do%>
        <%= render_slot(@inner_block) %>
      <% end %>
    <% end %>
    """
  end
end
