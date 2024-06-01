defmodule MinimalWeb.Router do
  use Phoenix.Router

  get("/", MinimalWeb.HomeController, :index)
  get("/details", MinimalWeb.DetailsController, :index)
end
