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
			p1_name: "ethan",
			p2_name: "justin",
			p1_deck: p1_deck(),
			p2_deck: p2_deck(),
	
			p1_curr_card: 0, # first item in list
			p2_curr_card: 0, # first item in list
			isGameOver: false,
		}
	end

	def client_view(game) do
		p1_name = game.p1_name;
		p2_name = game.p2_name;
		p1_deck = game.p1_deck;
		p2_deck = game.p2_deck;
		p1_curr_card = game.p1_curr_card;
		p2_curr_card = game.p2_curr_card;

		%{
			p1_name: p1_name,
			p2_name: p2_name,
			p1_deck: p1_deck,
			p2_deck: p2_deck,
			p1_curr_card: p1_curr_card,
			p2_curr_card: p2_curr_card,
		}
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
	
	def p1_deck() do
		move1 = %{ :name => "swipe", :damage => 10 }
		card1 = %{ :id => 1, :name => "red ghost", :img_src => "red_ghost",
							 :health => 20, :moves => [move1] }
		[card1]
	end

	def p2_deck() do
		move1 = %{ :name => "kick", :damage => 10 } 
		card1 = %{ :id => 2, :name => "blue ghost", :img_src => "blue_ghost",
							 :health => 40, :moves => [move1] }
		move2 = %{ :name => "fireball", :damage => 15 }
		card2 = %{ :id => 3, :name => "green ghost", :img_src => "green_ghost",
							 :health => 5, :moves=> [move2] }
		[card1, card2] 
	end
end





# can implement later:
# pokemon types
# picking your pokemon

IO.inspect(Project1.Game.new())
