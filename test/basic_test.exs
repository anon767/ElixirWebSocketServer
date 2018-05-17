defmodule BasicTest do
  use ExUnit.Case

  def listen(port) do
    listen(port, &handler/1)
  end

  def listen(port, handler) do
    IO.puts "listen"
    Socket.TCP.listen!(port, packet: :line)
    |> accept(handler)
  end

  def accept(listening_socket, handler) do
    IO.puts "accept"
    socket = Socket.TCP.accept!(listening_socket)
    spawn(fn -> handle(socket, handler) end)
    accept(listening_socket, handler)
  end

  def handle(socket, handler) do
    IO.puts "handle"
    incoming = Socket.Stream.recv!(socket)
    socket |> Socket.Stream.send!(handler.(incoming))
    handle(socket, handler)
  end

  def handler(line) when (line) do
    String.upcase(line)
  end



end

BasicTest.listen(4000)