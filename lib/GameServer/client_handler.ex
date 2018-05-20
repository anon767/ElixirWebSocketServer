defmodule GameServer.ClientHandler do
  def run(opts) do

    case  opts.client
          |> Socket.Web.recv do
      {:ok, line} ->
        State.ClientMap.apply(
          opts.clientMap,
          fn {_, client} ->
            client
            |> Socket.Web.send({:text, "hi"})
          end
        )

        run(opts)
      {:error, _} ->
        opts.client
        |> Socket.Web.close
    end

  end
end