let data = [|
  ("Ocaml", "https://ocaml.org/docs", "https://ocaml.org/img/learn/dark-hero-camel.svg");
  ("HTMX", "https://htmx.org/docs", "https://htmx.org/img/htmx_logo.2.png");
  ("Dream", "https://aantron.github.io/dream/", "https://opengraph.githubassets.com/4be9b09c57fb4bcf499d93e65c67b13d4b48e9286353e1b005d5b9496d064758/aantron/dream")
|];;

let ul data =
  <ul>
%   data |> Array.iter begin fun (name, url, img) ->
    <li>
      <img src="<%s img %>" width="100" height="100">
      <a href="<%s url %>"><%s name %></a>
    </li>
%   end;
  </ul>

let () =
  Dream.run?port:(Some 3000)
    @@ Dream.router [
    Dream.get "/assets/**" @@ Dream.static "./assets";
    Dream.get "/" (Dream.from_filesystem "." "index.html");
    Dream.get "/details" (fun _ -> Dream.html (ul data));
  ];;
