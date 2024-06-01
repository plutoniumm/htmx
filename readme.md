# HTMX Templates

<div align="center">
  <img src="https://i.imgur.com/SqUo9lJ.png" width="330px" alt="something something peace">
</div>

## Usage

```sh
# wild isnt it, just curl it in
sh <(curl -L "https://plutoniumm.github.io/htmx/create")
```

(Language + Runtime with Renderer)
- [`c-none`](./c-none/readme.md): C (the full chad lifestyle, no deps)
- [`go-templ`](./go-templ/readme.md): Go + Echo with Templ
- [`haskell-yesod`](./haskell-yesod/readme.md): Haskell + Yesod with Shakespeare
- [`lua-pegasus`](./lua-pegasus/readme.md): Lua with Pegasus
- [`ocaml-dream`](./ocaml-dream/readme.md): OCaml + Dream
- [`php-none`](./php-none/readme.md): PHP + PHP with PHP
- [`python-jinja`](./python-jinja/readme.md): Python + Flask with Jinja2
- [`ruby-rails`](./ruby-rails/readme.md): Ruby + Rails with ERB
- [`rust-leptos`](./rust-leptos/readme.md): Rust + Actix with Leptos
- [`ts-bun`](./ts-bun/readme.md): TSX + Bun with Hono

## Notes
- The idea was to take the most popular frameworks and strip them down to then allow you to incrementally add features as needed using whatever hammer you see fit
-  HTML Escaping, XSS/CSRF, SQL Injection etc are not my problems to deal with. Please watch out. All input is error.