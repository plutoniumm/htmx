defmodule MinimalWeb.DetailsController do
  require Logger
  use Phoenix.Controller, namespace: MinimalWeb

  def index(conn, _params) do
    data = [
      ['Phoenix', 'https://www.phoenixframework.org/', 'https://hexdocs.pm/phoenix/assets/logo.png'],
      ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png'],
      ['Hono', 'https://hono.dev/', 'https://hono.dev/images/logo.png'],
    ]

    lis = Enum.map(data, fn [name, url, img] ->
      """
      <li>
        <img src="#{img}" alt="#{name} logo" />
        <a href="#{url}" target="_blank">#{name}</a>
      </li>
      """
    end) |> Enum.join("\n")

    Phoenix.Controller.html(conn, """
         <ul>#{lis}</ul>
    """)
  end
end
