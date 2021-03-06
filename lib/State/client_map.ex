defmodule State.ClientMap do
  use Agent

  @doc """
  Starts.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the by `key`.
  """
  def get(clientMap, key) do
    Agent.get(clientMap, &Map.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key`.
  """
  def put(clientMap, key, value) do
    Agent.update(clientMap, &Map.put(&1, key, value))
  end

  def size(clientMap) do
    Agent.get(clientMap, &Map.size &1)
  end

  def remove(clientMap, key) do
    Agent.update(clientMap, &Map.delete(&1, key))
  end

  def apply(clientMap, handler) do
    Agent.get(clientMap, &Enum.each(&1, handler))
  end

end