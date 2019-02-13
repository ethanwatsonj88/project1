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
	#		%{ :name => "name", :health => 10, :moves => moves }
	# moves - map of move name and damage
	#		%{ :name => "name", :damage => 10 }

	# functions called from react
	# action(player,

	def new do
		%{
			# new should be passed in the two names
			p1name: "",
			p2name: "",
			p1cards: p1Cards(),
			p2cards: p2Cards(),

			p1currCard: nil,
			p2currCard: nil,
			isGameOver: false,
		}
	end

	def client_view(game) do

	end

	def p1Cards() do
		move1 = %{ :name => "punch", :damage => 10 }
		card1 = %{ :name => "pikachu", :health => 20, :moves => [move1] }
		[card1]
	end

	def p2Cards() do
		move1 = %{ :name => "kick", :damage => 10 } 
		card1 = %{ :name => "macho", :health => 40, :moves => [move1] }
		[card1] 
	end
end





# can implement later:
# pokemon types
# picking your pokemon
