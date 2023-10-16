use actix_files::{Files, NamedFile};

use actix_web::http::header::ContentType;
// ive done * so its easier to get started,
// narrow them down as the application is ready for prod
use actix_web::*;
use leptos::*;
use std::env;

async fn index(_req: HttpRequest) -> Result<NamedFile> {
    return Ok(NamedFile::open("index.html")?);
}

// leptos /details render
#[get("/details")]
async fn deets(_req: HttpRequest) -> HttpResponse {
    let data = [
        ("Rust", "https://doc.rust-lang.org/std/", "https://i.imgur.com/vIsMwPx.png"),
        ("HTMX", "https://htmx.org/docs", "https://htmx.org/img/htmx_logo.2.png"),
        ("Actix", "https://actix.rs/docs", "https://actix.rs/img/logo.png"),
        ("Leptos", "https://leptos-rs.github.io/leptos/", "https://leptos.dev/images/leptos_circle.svg"),
    ];

    let html = leptos::ssr::render_to_string(move || {
        return view! {
            <h3 style="text-align:center;">"Welcome to HTMX!"</h3>
            <p>"You're using these tools, check their docs to learn more:"</p>
            <ul>
            {
                data.into_iter()
                .map(|item| view! {
                    <li>
                        <img src={item.2} />
                        <a href={item.1}>{item.0}</a>
                    </li>
                })
                .collect::<Vec<_>>()
            }
            </ul>
        };
    }).into_owned();

    return HttpResponse::Ok()
        .content_type(ContentType::html())
        .body(html);
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();
    let port = &args[1];
    let port: u16 = port.parse().unwrap();

    println!("Starting server on port {}", port);

    return HttpServer::new(||
        App::new()
        .route("/", web::get().to(index))
        .service(deets)
        .service(Files::new("/assets", "assets").show_files_listing())
    )
    .bind(("127.0.0.1", port))?
    .run()
    .await;
}