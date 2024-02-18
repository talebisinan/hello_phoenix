defmodule HelloPhoenixWeb.LightLive do
  use HelloPhoenixWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="space-y-2">
      <h1 class="text-gray-800 font-semibold text-lg">Front porch light</h1>
      
      <div class="rounded-lg bg-gray-300 flex items-center jusify-center h-10">
        <div
          class="bg-yellow-500 rounded-lg h-full inline-flex items-center justify-center transition-all duration-1000"
          style={"width: #{@brightness}%;"}
        >
          <span class="text-gray-800 font-medium"><%= @brightness %>%</span>
        </div>
      </div>
    </div>

    <div class="mt-4 flex flex-wrap gap-6">
      <button phx-click="off">Light Off</button> <button phx-click="down">-10 Brightness</button>
      <button phx-click="up">+10 Brightness</button> <button phx-click="on">Lights On</button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end

  def handle_event("off", _, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end

  def handle_event("up", _, socket) do
    {:noreply, assign(socket, brightness: min(socket.assigns.brightness + 10, 100))}
  end

  def handle_event("down", _, socket) do
    {:noreply, assign(socket, brightness: max(socket.assigns.brightness - 10, 0))}
  end

  # def handle_event(event, unsigned_params, socket) do
  #   case event do
  #     "off" ->
  #       {:noreply, assign(socket, brightness: 0)}

  #     "on" ->
  #       {:noreply, assign(socket, brightness: 100)}

  #     _ ->
  #       {:noreply, socket}
  #   end
  # end
end
