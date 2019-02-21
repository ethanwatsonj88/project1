defmodule Project1Web.GamesChannel do
  use Project1Web, :channel

  intercept ["update"]

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      Project1.GameServer.start(name)
      socket = socket
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Project1.GameServer.client_view(name)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("fight", %{"player" => n, "move_damage" => d}, socket) do
    room_name = socket.assigns[:name]
    Project1.GameServer.fight(room_name, n, d)
    view = Project1.GameServer.client_view(room_name)
    push_update!(view, socket)
    {:reply, {:ok, %{"game" => view}}, socket}
  end

  def handle_in("switch", %{"player" => n, "ind" => i}, socket) do
    room_name = socket.assigns[:name]
    Project1.GameServer.switch(room_name, n, i)
    view = Project1.GameServer.client_view(room_name)
    push_update!(view, socket)
    {:reply, {:ok, %{"game" => view}}, socket}
  end

  def handle_in("giveup", %{"player" => n}, socket) do
    room_name = socket.assigns[:name]
    Project1.GameServer.giveup(room_name, n)
    view = Project1.GameServer.client_view(room_name)
    push_update!(view, socket)
    {:reply, {:ok, %{"game" => view}}, socket}
  end

  def handle_out("update", game_data, socket) do
    push(socket, "update", %{"game" => game_data})
    {:noreply, socket}
  end

  defp push_update!(view, socket) do
    broadcast!(socket, "update", view)
  end

  defp authorized?(_payload) do
    true
  end
end
