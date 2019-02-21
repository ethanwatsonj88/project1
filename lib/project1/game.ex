defmodule Project1.Game do
'''
  def new() do
    %{
      p1: nil,
      p2: nil,
      condition: :wait,
    }
  end

  def join(game, name) do
    if !game[:p1] do
      %{
        p1: player(name, p1Cards(), 0),
        p2: nil,
        condition: :wait,
      }
    else
  		%{
        p1: game[:p1],
        p2: player(name, p2Cards(), 0),
        condition: game[:p1] <> "turn",
  		}
  	end
  end
'''
  def new() do
    %{
      p1: player("justin", p1Cards(), 0),
      p2: player("ethan", p2Cards(), 0),
      condition: "justin" <> "turn",
  }
  end

  def getPlayer(game, name) do
    if name == game[:p1][:name] do
      :p1
    else
      :p2
    end
  end

  def getOtherPlayer(game, name) do
    if name == game[:p1][:name] do
      :p2
    else
      :p1
    end
  end

  def player(name, cards, ind) do
    %{
      name: name,
      cards: cards,
      ind: ind,
    }
  end

  def fight(game, name, dmg) do
    a = getOtherPlayer(game, name)
    b = game[a]
    ind = b[:ind]

    c = b
    |> Map.fetch!(:cards)
    |> Enum.at(ind)
    |> Map.update!(:health, fn x -> x - dmg end)

    m = Map.replace!(game, a, Map.replace!(b, :cards,
                 List.replace_at(b[:cards], ind, c)))

    fightHelper = fn _ ->
      if c[:health] > 0 do
        b[:name] <> "turn"
      else
        i = List.foldr(m[a][:cards], 0,
                   fn x, acc -> if x[:health] > 0 do acc + 1 else acc end end)
        if i == 0 do
          name <> "win"
        else
          b[:name] <> "switch"
        end
      end
    end

    Map.update!(m, :condition, fightHelper)
  end

  #TODO check if switch > 0
  def switch(game, name, ind) do
    a = getPlayer(game, name)
    b = game
    |> Map.fetch!(a)
    |> Map.replace!(:ind, ind)

    Map.replace!(game, a, b)
    |> Map.replace!(:condition, game[getOtherPlayer(game, name)][:name] <> "turn")
  end

  def giveup(game, name) do
    a = getOtherPlayer(game, name)
    Map.replace!(game, :condition, a[:name] <> "win")
  end

	def client_view(game) do
		p1_name = game[:p1][:name]
		p2_name = game[:p2][:name]
		p1_deck = game[:p1][:cards]
		p2_deck = game[:p2][:cards]
		p1_curr_card = game[:p1][:ind]
		p2_curr_card = game[:p2][:ind]
    condition = game[:condition]

		%{
			p1_name: p1_name,
			p2_name: p2_name,
			p1_deck: p1_deck,
			p2_deck: p2_deck,
			p1_curr_card: p1_curr_card,
			p2_curr_card: p2_curr_card,
      condition: condition,
		}
	end

	def p1Cards() do
		moves = [%{ :name => "punch", :damage => 10 },
             %{ :name => "kick", :damage => 20 },
             %{ :name => "headbutt", :damage => 30},
             %{ :name => "split", :damage => 40},]
		card = %{ :name => "blue ghost", :health => 20, :moves => moves, :img_src => "blue_ghost" }
		card2 = %{ :name => "red ghost", :health => 50, :moves => moves, :img_src => "red_ghost" }
		pineapple_moves = [	%{ :name => "fruit punch", :damage => 14 },
												%{ :name => "blender", :damage => 26 },
												%{ :name => "spray", :damage => 9 },
												%{ :name => "fortify", :damage => 0},]
		pineapple_card = %{ :name => "pineapple", :health => 22, :moves => pineapple_moves, :img_src => "pineapple" }
		eagle_moves = [ %{ :name => "wind tunnel", :damage => 7 },
										%{ :name => "fly and dive", :damage => 20 },
										%{ :name => "poke", :damage => 3 },
										%{ :name => "bird poop", :damage => 25 },]
		eagle_card = %{ :name => "eagle", :health => 17, :moves => eagle_moves, :img_src => "eagle" }
		cucumber_moves = [	%{ :name => "jamaican rap", :damage => 15 },
												%{ :name => "spray water", :damage => 2 },
												%{ :name => "vegetable", :damage => 0 },
												%{ :name => "put in a sock and wham", :damage => 30 },]
		cucumber_card = %{ :name => "cucumber", :health => 48, :moves => cucumber_moves, :img_src => "cucumber" }
		[card, card2, pineapple_card, cucumber_card]

	end

	def p2Cards() do
		moves = [%{ :name => "punch", :damage => 10 },
             %{ :name => "kick", :damage => 20 },
             %{ :name => "headbutt", :damage => 30},
             %{ :name => "split", :damage => 40},]
		card = %{ :name => "yellow ghost", :health => 33, :moves => moves, :img_src => "yellow_ghost" }
		card2 = %{ :name => "purple ghost", :health => 30, :moves => moves, :img_src => "purple_ghost" }
		card3 = %{ :name => "blue boy", :health => 42, :moves => moves, :img_src => "blue_boy" }
	
    [card, card2, card3]
	end
end
