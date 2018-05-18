
defmodule SocketTest do
  use ExUnit.Case, async: true



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

  send = "test"
  Process.sleep(1000)
  IO.puts "testing text send/recv"
  socket = Socket.Web.connect! "localhost", 4000
  socket
  |> (Socket.Web.send! {:text, send})
  {:text, receive} = socket
                     |> Socket.Web.recv!

  assert(send == receive)

  send = <<256::16>>
  Process.sleep(1000)
  IO.puts "testing binary send/recv"
  socket = Socket.Web.connect! "localhost", 4000
  socket
  |> (Socket.Web.send! {:binary, send})
  {:binary, receive} = socket
                     |> Socket.Web.recv!

  assert(send == receive)

end