defmodule BinaryProtocolTest do
  use ExUnit.Case, async: true

  lStruct = %GameServer.ReceiveMessage{left: 0, right: 0, action: 1, angle: 1}

  rStruct = GameServer.ReceiveMessage.parseBinary(<<0, 0, 1, 1>>)

  assert lStruct == rStruct
end