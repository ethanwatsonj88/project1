defmodule Project1Web.GamesChannel do
  use Project1Web, :channel

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      g = Project1.GameServer.start(name)
      game = Project1.GameServer.client_view(name)
      socket = socket
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Project1.Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("fight", %{"name" => n, "dmg" => d}, socket) do
    game = Project1.GameServer.fight(socket.assigns[:name], n, d)
    {:reply, {:ok, %{"game" => Project1.Game.client_view(game)}}, socket}
  end

  def handle_in("switch", %{"name" => n, "ind" => i}, socket) do
    game = Project1.GameServer.switch(socket.assigns[:name], n, i)
    {:reply, {:ok, %{"game" => Project1.Game.client_view(game)}}, socket}
  end

  def handle_in("giveup", %{"name" => n}, socket) do
    game = Project1.GameServer.giveup(socket.assigns[:name], n)
    {:reply, {:ok, %{"game" => Project1.Game.client_view(game)}}, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
