defmodule TrackerWeb.ModalComponent do
  use TrackerWeb, :live_component

  def render(assigns) do
    ~H"""
    <.modal>
      <.live_component {@content_attrs}/>
    </.modal>
    """
  end
end
