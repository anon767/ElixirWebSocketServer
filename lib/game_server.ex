defmodule GameServer do
  use Application




  def init() do
    import Supervisor.Spec
    children = [
      worker(State.World, [[name: :world]]),
      worker(GameServer.SocketServer, [4000]),
      worker(State.ClientMap, [[name: State.ClientMap]]),
      supervisor(Task.Supervisor, [[name: :game_handler]], id: :game_handler)
    ]

    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)




  end

  def start(_, _) do
    init()
    IO.puts "start"
  end

  def main(args) do # entry point
    init()
    IO.inspect args
  end




end