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

  def start_link(port, handler) do
    {:ok, socket} = GameServer.Socket.listen(port)
    {:ok, spawn_link fn -> accept(socket, handler) end}
    GenServer.start_link(__MODULE__, :ok)
  end

  def accept(socket, handler) do
    client = socket
             |> Socket.Web.accept!
    GameServer.Socket.accept(client)

    spawn_link fn -> GameServer.SocketServer.handle(client, handler) end
    accept(socket, handler)
  end

  def handle(client, handler) do
    handler.(client)
  end

end