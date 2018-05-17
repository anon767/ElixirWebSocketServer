Game.Socket.listen(4000, fn (client, line) -> client |> Socket.Web.send!(line) end)

