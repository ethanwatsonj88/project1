defmodule Project1.Game do

	# stages of the game:
	# picking cards
	#		present 5 cards
	# 	p1 and p2 pick cards simultaneously
	#		p1 and p2 ready up
	# 	moves on to game

	# !!!!start with this:
	#		p1 moves first
	#		sends action



	# data structures
	# p1name - string that user types in
	# p2name - string that user types in
	# p1cards - list of cards player has
	# p2cards - list of cards player has
	# card - map of attributes of a card
			%{ :name => "name", :actions => moves }
	# moves - map of move name and damage
			%{ :name => "name", :damage => 10 }

	def new do
		%{
			p1name: "",
			p2name: "",
			p1cards:[],
			p2cards:[],

			p1currCard: nil,
			p2currCard: nil,
		}
	end

	def client_view(game) do

	end

end


# can implement later:
# pokemon types
# picking your pokemon
