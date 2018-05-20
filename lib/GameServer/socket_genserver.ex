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

    {:ok, spawn_link fn -> accept(socket) end}
    GenServer.start_link(__MODULE__, :ok)
  end



  def accept(socket) do
    client = socket
             |> Socket.Web.accept!

    client |> Socket.Web.accept!

    Task.Supervisor.start_child(:game_handler, GameServer.ClientHandler, :run, [%{client: client}])

    GameServer.SocketServer.accept(socket)
  end



end