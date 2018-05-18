ExUnit.start

{:ok, server} = GameServer.Socket.listen(4000)

spawn(
  fn ->
    GameServer.Socket.accept(
      server,
      fn (client, line) ->
        client
        |> Socket.Web.send(line)
        client
        |> Socket.Web.close
      end
    )
  end
)