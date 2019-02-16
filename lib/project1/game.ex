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
		[p1CardsHead | p1CardsTail] = p1Cards()
		[p2CardsHead | p2CardsTail] = p2Cards()		

		%{
			# new should be passed in the two names
			p1Name: "player1",
			p2Name: "player2",
			p1Deck: p1CardsTail,
			p2Deck: p2CardsTail,
	
			p1CurrCard: p1CardsHead,
			p2CurrCard: p1CardsTail,
			isGameOver: false,
		}
	end

	def client_view(game) do

	end

	# player chose to fight with currCard
	# player is string of player name
	# card is a card
	# move is a move
	def move(game, player, move) do
		if player == game.p1Name do
			# player one's turn
			# we should damage player2's card based on damage in move
			p2CurrCard = game.p2CurrCard
			moveDamage = Map.get(move, :damage)
			p2CurrCard.
		else

		end
	end

	# player chose to switch card to different card in dekc for turn
	def switchCard() do

	end
	
	# returns the first card in a list of cards for currCard state field
	def firstCard([head | tail]) do
		head
	end

	def p1Cards() do
		move1 = %{ :name => "punch", :damage => 10 }
		card1 = %{ :name => "pikachu", :health => 20, :moves => [move1] }
		[card1]
	end

	def p2Cards() do
		move1 = %{ :name => "kick", :damage => 10 } 
		card1 = %{ :name => "macho", :health => 40, :moves => [move1] }
		move2 = %{ :name => "fireball", :damage => 15 }
		card2 = %{ :name => "charizard", :health => 5, :moves=> [move2] }
		[card1, card2] 
	end
end





# can implement later:
# pokemon types
# picking your pokemon

IO.inspect(Project1.Game.new())
