using Mustache
using Oxygen
using HTTP


@get "/" function( req:: HTTP.Request )
  return file("index.html");
end


function li(name, href, img)
  temp = mt"""<li>
    <img src="{{img}}" alt="{{name}}">
    <a href="{{href}}">{{name}}</a>
  </li>"""

  return Mustache.render(
    temp, Dict("name" => name, "href" => href, "img" => img)
  );
end

@get "/details" function( req:: HTTP.Request )
  data = [
    Dict("name" => "Oxygen", "href" => "https://oxygenframework.github.io/Oxygen.jl/stable/", "img" => "https://oxygenframework.github.io/Oxygen.jl/stable/oxygen.png"),
    Dict("name" => "HTMX", "href" => "https://htmx.org/docs", "img" => "https://htmx.org/img/htmx_logo.2.png"),
    Dict("name" => "Moustache", "href" => "https://mustache.github.io/", "img" => "#")
  ];

  temp = mt"""
    <h3 style="text-align:center;">Welcome to HTMX!</h3>
    <p>You're using these tools, check their docs to learn more:</p>
    <ul>
      {{#:data}}
        <li>
          <img src="{{img}}" alt="{{name}}">
          <a href="{{href}}">{{name}}</a>
        </li>
      {{/:data}}
    </ul>
  """

  return Mustache.render(temp, Dict("data" => data));
end

staticfiles("assets", "assets");
serve(port=3000);