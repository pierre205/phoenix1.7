defmodule TestMoningWeb.HelloController do
  use TestMoningWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
