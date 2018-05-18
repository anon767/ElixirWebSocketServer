defmodule State.WorldTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(State.World)
    %{registry: registry}
  end


  test "test add player", %{registry: registry} do
    assert State.World.lookup(registry, 0) == :error

    State.World.create(registry, "randomClient")
    assert {:ok, clientMap} = State.World.lookup(registry, "randomClient")

    State.ClientMap.put(clientMap, 1, "tom")
    assert State.ClientMap.get(clientMap, 1) == "tom"
  end

  test "iterate (apply) through clients", %{registry: registry} do
    State.World.create(registry, "randomClient")
    {:ok, clientMap} = State.World.lookup(registry, "randomClient")
    State.ClientMap.put(clientMap, 0, "tom")
    State.ClientMap.put(clientMap, 1, "toma")
    assert :ok == State.ClientMap.apply(clientMap, fn {_, client} -> (client) end)
  end
end