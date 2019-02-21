defmodule Project1Web.PageController do
  use Project1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

	def join(conn, %{"join" => %{"p_name" => p_name, "server_name" => server_name}}) do
		conn
		|> put_session(:p_name, p_name)
		|> redirect(to: "/game/#{server_name}")
	end

	def game(conn, params) do
		p_name = get_session(conn, :p_name)
		if p_name do
			render(conn, "game.html", server_name: params["server_name"], p_name: p_name)
		else 
			conn
			|> put_flash(:error, "Must pick a username")
			|> redirect(to: "/")
		end
	end
end
