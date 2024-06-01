defmodule MinimalWeb.ErrorView do
  require Logger

  def index(_conn, _params) do
      Logger.info  "Not Found!"
  end
end
