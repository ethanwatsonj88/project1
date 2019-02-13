# Project1

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Fight
### data structures
	* p1name - string that user types in
	* p2name - string that user types in
	* p1cards - list of cards player has
	* p2cards - list of cards player has
	* card - map of attributes of a card
		%{ :name => "name", :actions => moves }
	* moves - map of move name and damage
		%{ :name => "name", :damage => 10 }
