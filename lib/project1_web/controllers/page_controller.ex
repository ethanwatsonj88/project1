defmodule Project1Web.PageController do
  use Project1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

	def game(conn, %{"name" => name, "p_name" => p_name}) do
		render(conn, "game.html", name: name, p_name: p_name)
	end
end
