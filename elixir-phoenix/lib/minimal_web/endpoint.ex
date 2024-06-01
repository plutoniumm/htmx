defmodule MinimalWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :minimal

  plug Plug.Static,
    at: "/assets",
    from: "assets"

  plug(MinimalWeb.Router)
end
