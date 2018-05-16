defmodule BinaryDataOverPhoenixSocket.PageController do
  use BinaryDataOverPhoenixSocket.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
