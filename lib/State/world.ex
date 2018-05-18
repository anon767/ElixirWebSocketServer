defmodule State.World do
  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, id) do
    GenServer.call(server, {:lookup, id})
  end

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def create(server, id) do
    GenServer.cast(server, {:create, id})
  end

  def apply(server, handler) do
    GenServer.cast(server, {:apply, handler})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:lookup, id}, _from, clients) do
    {:reply, Map.fetch(clients, id), clients}
  end

  def handle_cast({:apply, handler}, clients) do
    Enum.each(clients, handler)
    {:ok, clients}
  end

  def handle_cast({:create, id}, clients) do
    if Map.has_key?(clients, id) do
      {:noreply, clients}
    else
      {:ok, clientMap} = State.ClientMap.start_link([])
      {:noreply, Map.put(clients, id, clientMap)}
    end
  end
end