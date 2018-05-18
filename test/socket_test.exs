defmodule SocketTest do
  use ExUnit.Case, async: true




  test "testing text send/recv" do
    send = "test"
    socket = Socket.Web.connect! "localhost", 4000
    socket
    |> (Socket.Web.send! {:text, send})
    {:text, receive} = socket
                       |> Socket.Web.recv!
    assert(send == receive)
  end
  
  test "testing binary send/recv" do
    send = <<256 :: 16>>
    socket = Socket.Web.connect! "localhost", 4000
    socket
    |> (Socket.Web.send! {:binary, send})
    {:binary, receive} = socket
                         |> Socket.Web.recv!

    assert(send == receive)
  end
end