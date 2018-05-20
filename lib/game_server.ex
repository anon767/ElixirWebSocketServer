defmodule GameServer do
  use Application




  def init() do
    import Supervisor.Spec
    children = [
      worker(GameServer.SocketServer, [4000]),
      {State.World, name: State.World},
      supervisor(Task.Supervisor, [[name: :game_handler]], id: :game_handler)
    ]
    Supervisor.start_link(children, strategy: :one_for_one)

    #    GameServer.SocketServer.start_link(
    #      4000,
    #      &(GameServer.handler &1, &2)
    #    )

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