# referenced from Nat Tuck's lecture notes
defmodule Project1.GameServer do
  use GenServer

  def reg(name) do
    {:via, Registry, {Project1.GameReg, name}}
  end

  def start(name) do
    spec = %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]},
      restart: :permanent,
      type: :worker,
    }
    Project1.GameSup.start_child(spec)
  end

  def start_link(room_name) do
    game = Project1.BackupAgent.get(room_name) || Project1.Game.new()
    GenServer.start_link(__MODULE__, game, name: reg(room_name))
  end

  def fight(room_name, name, dmg) do
    GenServer.call(reg(room_name), {:fight, room_name, name, dmg})
  end

  def switch(room_name, name, ind) do
    GenServer.call(reg(room_name), {:switch, room_name, name, ind})
  end

  def giveup(room_name, name) do
    GenServer.call(reg(room_name), {:giveup, room_name, name})
  end

  def client_view(room_name) do
    GenServer.call(reg(room_name), {:client_view, room_name})
  end

  def handle_call({:fight, room_name, name, dmg}, _from, game) do
    game = Project1.Game.fight(game, name, dmg)
    Project1.BackupAgent.put(room_name, game)
    {:reply, Project1.Game.client_view(game), game}
  end

  def handle_call({:switch, room_name, name, ind}, _from, game) do
    game = Project1.Game.switch(game, name, ind)
    Project1.BackupAgent.put(room_name, game)
    {:reply, Project1.Game.client_view(game), game}
  end

  def handle_call({:giveup, room_name, name}, _from, game) do
    game = Project1.Game.giveup(game, name)
    Project1.BackupAgent.put(room_name, game)
    {:reply, Project1.Game.client_view(game), game}
  end

  def handle_call({:client_view, room_name}, _from, game) do
    {:reply, Project1.Game.client_view(game), game}
  end

  def init(game) do
    {:ok, game}
  end
end
