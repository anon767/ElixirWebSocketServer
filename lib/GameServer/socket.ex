defmodule GameServer.Socket do

  def listen(port) do
    case Socket.Web.listen(port) do
      {:ok, server} -> {:ok, server}
      _ -> {:error}
    end
  end

  def accept(client) do
    client
    |> Socket.Web.accept!
    {:ok}
  end

  def handle(client, handler) do
    result = client
             |> Socket.Web.recv

    handler.(client, result)
  end
end
