defmodule Project1Web.GamesChannel do
  use Project1Web, :channel
	
	alias Project1.Game
	
  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
			game = Game.new("justin", "ethan")
			socket = socket
			|> assign(:game, game)
			|> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

	def handle_in("fight", %{"letter" => ll `}, socket) do
		game = Game.fight(socket.assigns[:game], ll)
		socket = assign(socket, :game, game)
		{:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
	end

	def handle_in("switch", %{"letter" => ll }, socket) do
		game = Game.switch(socket.assign[:game], ll)
		socket = assign(socket, :game, game)
		{:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
	end

	def handle_in("give_up", %{"letter" => ll }, socket) do
		game = Game.switch(socket.assign[:game], ll)
		{:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
	end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end	

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
