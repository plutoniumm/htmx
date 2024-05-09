# HTMX Templates

<div align="center">
  <img src="https://i.imgur.com/SqUo9lJ.png" width="330px" alt="something something peace">
</div>

(Language + Runtime with Renderer)
- `ts-bun`: TSX + Bun with Hono
- `go-templ`: Go + Echo with Templ
- `rust-leptos`: Rust + Actix with Leptos
- `py-flask`: Python + Flask with Jinja2
- `hs-yesod`: Haskell + Yesod with Shakespeare
- `c-none`: C (the full chad lifestyle, no ext deps)

> HTML Escaping, XSS/CSRF, SQL Injection etc are not my problems to deal with. Please watch out.

## Usage
- [c-none](#c-none)
- [go-templ](#go-templ)
- [python-jinja](#python-jinja)
- [ts-bun](#ts-bun)
- [rust-leptos](#rust-leptos)

### c-none
```sh
gcc *.c -o main -O2;
./main
```

### go-templ
```sh
go run *.go
```

### python-jinja
```sh
pip install -r requirements.txt
python index.py
```

### ts-bun
```sh
pnpm install
npm run dev
```

### rust-leptos
```sh
cargo run 3000
```

### haskell-yesod
```sh
stack run
```