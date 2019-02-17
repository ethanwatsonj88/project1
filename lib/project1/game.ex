defmodule Project1.Game do
#	def new(p1name, p2name, p1cards, p2cards) do
  def new(p1name, p2name) do
		%{
      p1: player(p1name, p1Cards(), 0),
      p2: player(p2name, p1Cards(), 0),
      condition: p1name <> "turn",
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

    fightHelper = fn _ ->
      if c[:health] > 0 do
        b[:name] <> "turn"
      else
      #TODO fix
        if (List.foldr(b[:cards], 0,
                 #fn x, acc -> if x[:health] > 0 do acc + 1 else acc end end)
                 fn _, _ -> 0 end)
                 == 0) do
          name <> "win"
        else
          b[:name] <> "switch"
        end
      end
    end

    Map.replace!(game, a, Map.replace!(b, :cards,
                 List.replace_at(b[:cards], ind, c)))
    |> Map.update!(:condition, fightHelper)
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
		p1_name = game[:p1][:name];
		p2_name = game[:p2][:name];
		p1_deck = game[:p1][:cards];
		p2_deck = game[:p2][:cards];
		p1_curr_card = game[:p1][:ind];
		p2_curr_card = game[:p2][:ind];

		%{
			p1_name: p1_name,
			p2_name: p2_name,
			p1_deck: p1_deck,
			p2_deck: p2_deck,
			p1_curr_card: p1_curr_card,
			p2_curr_card: p2_curr_card,
		}
	end

	def p1Cards() do
		moves = [%{ :name => "punch", :damage => 10 },
             %{ :name => "kick", :damage => 20 },
             %{ :name => "headbutt", :damage => 30},
             %{ :name => "split", :damage => 40},]
		card = %{ :name => "pikachu", :health => 20, :moves => moves, :img_source => "blue_ghost" }
    [card, card]
	end
end
