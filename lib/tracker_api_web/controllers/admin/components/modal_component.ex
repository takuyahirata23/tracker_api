defmodule TrackerWeb.ModalComponent do
  use TrackerWeb, :live_component

  def show_modal(attrs) do
    send_update(self(), __MODULE__, id: "modal", show: attrs.show, content_attrs: attrs)
  end

  def close_modal() do
    send_update(self(), __MODULE__, id: "modal", show: false)
  end

  def update(assigns, socket) do
    case assigns[:show] do
      true -> {:ok, assign(socket, show: true, content_attrs: assigns.content_attrs)}
      _ -> {:ok, assign(socket, show: false)}
    end
  end

  def render(assigns) do
    ~H"""
    <div class={unless @show, do: "hidden"}>
    <%= if @show do %>
      <.modal>
      <.live_component id="modal_content" {@content_attrs}/>
      </.modal>
      <% end %>
    </div>
    """
  end
end
