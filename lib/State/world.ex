defmodule State.World do
  use GenServer

  ## Client API


  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end


  def lookup(server, id) do
    GenServer.call(server, {:lookup, id})
  end


  def create(server, id) do
    GenServer.cast(server, {:create, id})
  end


  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:lookup, id}, _from, stateMap) do
    {:reply, Map.fetch(stateMap, id), stateMap}
  end
  

  def handle_cast({:create, id}, stateMap) do
    if Map.has_key?(stateMap, id) do
      {:noreply, stateMap}
    else
      {:ok, map} = State.ClientMap.start_link([])
      {:noreply, Map.put(stateMap, id, map)}
    end
  end
end