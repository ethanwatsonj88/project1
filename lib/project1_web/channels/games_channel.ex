defmodule Project1Web.GamesChannel do
  use Project1Web, :channel

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
    {:reply, {:ok, %{"game" => Project1.GameServer.client_view(room_name)}}, socket}
  end

  def handle_in("switch", %{"name" => n, "ind" => i}, socket) do
    room_name = socket.assigns[:name]
    Project1.GameServer.switch(room_name, n, i)
    {:reply, {:ok, %{"game" => Project1.GameServer.client_view(room_name)}}, socket}
  end

  def handle_in("giveup", %{"name" => n}, socket) do
    room_name = socket.assigns[:name]
    Project1.GameServer.giveup(room_name, n)
    {:reply, {:ok, %{"game" => Project1.GameServer.client_view(room_name)}}, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
