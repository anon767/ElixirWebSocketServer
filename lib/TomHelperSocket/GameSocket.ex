defmodule Game.Socket do

  def listen(port) do
    IO.puts "listen"
    case Socket.Web.listen(port) do
      {:ok, server} -> {:ok, server}
      _ -> {:error}
    end

  end


  def accept(server, handler) do
    client = server
             |> Socket.Web.accept!

    client
    |> Socket.Web.accept!
    handle(client, handler)
    Game.Socket.accept(server, handler)
  end

  def handle(client, handler) do
    case client
         |> Socket.Web.recv do
      {:ok, incoming} ->
        handler.(client, incoming)
      {:error, _} -> {:error}
    end
  end




end
