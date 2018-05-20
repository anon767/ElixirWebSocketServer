defmodule GameServer.ClientHandler do
  def run(opts) do

    case  opts.client
          |> Socket.Web.recv do
      {:ok, _} ->
        Socket.Web.send(opts.client, {:text, "hi"})
        run(opts)
      {:error, _} ->
        opts.client
        |> Socket.Web.close
    end

  end
end