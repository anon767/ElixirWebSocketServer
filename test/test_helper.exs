ExUnit.start
# Setting up the websocket server
defmodule InitTest do
  def start_link(port, handler) do
    {:ok, socket} = GameServer.Socket.listen(port)
    {:ok, spawn_link fn -> accept(socket, handler) end}
  end

  def accept(socket, handler) do
    client = socket
             |> Socket.Web.accept!
    GameServer.Socket.accept(client)
    {:ok, spawn_link fn -> GameServer.Socket.handle(client, handler) end}
    accept(socket, handler)
  end
end

InitTest.start_link(
  4000,
  fn (client, result) ->

    case result do
      {:ok, line} ->
        client
        |> Socket.Web.send(line)
        client
        |> Socket.Web.close
      {_, _} -> nil
    end
  end
)

