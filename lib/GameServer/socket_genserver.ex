defmodule GameServer.SocketServer do
  @moduledoc """
  Manages the connections on a socket for a single game
  backend. Each game backend has it's own SocketServer
  """

  use GenServer

  require Logger


  def init(:ok) do
    {:ok, %{}}
  end

  def start_link(port) do
    {:ok, socket} = GameServer.Socket.listen(port)

    State.World.create(:world, "clientMap")
    {:ok, clientMap} = State.World.lookup(:world, "clientMap")

    {:ok, spawn_link fn -> accept(socket, clientMap) end}
    GenServer.start_link(__MODULE__, :ok)
  end



  def accept(socket, clientMap) do
    client = socket
             |> Socket.Web.accept!
    State.ClientMap.put(clientMap, State.ClientMap.size(clientMap) + 1, client)
    client
    |> Socket.Web.accept!
    Task.Supervisor.start_child(
      :game_handler,
      GameServer.ClientHandler,
      :run,
      [%{client: client, clientMap: clientMap}]
    )

    GameServer.SocketServer.accept(socket, clientMap)
  end



end