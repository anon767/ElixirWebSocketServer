defmodule Game.Socket do

  def listen(port, handler) do
    IO.puts "listen"
    Socket.Web.listen!(port)
    |> accept(handler)
  end

  def accept(server, handler) do
    IO.puts "accept"
    client = server
             |> Socket.Web.accept!

    client
    |> Socket.Web.accept!
    spawn(fn -> handle(client, handler) end)
    Game.Socket.accept(server, handler)
  end

  def handle(client, handler) do
    IO.puts "handle"

    case client
         |> Socket.Web.recv do
      {:ok, incoming} ->
        handler.(client, incoming)
        Game.Socket.handle(client, handler)
      {:error, _} -> {:error}
    end
  end
end
