defmodule GameServer do
  use Application


  def handler(client) do
    result = client
             |> Socket.Web.recv
    case result do
      {:ok, line} ->
        client
        |> Socket.Web.send(line)
        GameServer.handler(client)
      {_, _} ->
        client
        |> Socket.Web.close
        exit(:shutdown)
    end
  end

  defp init() do
    import Supervisor.Spec
    children = [
      worker(GameServer.SocketServer, [4000, &(GameServer.handler &1)]),
      {State.World, name: State.World}
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