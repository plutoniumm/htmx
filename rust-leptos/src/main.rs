use actix_web::*;

// basic actix index.html example
#[get("/")]
async fn index(req: HttpRequest) -> HttpResponse {
    return HttpResponse::Ok()
        .content_type("text/html")
        .body(include_str!("./index.html"));
}

// static files
#[get("/assets/{filename}")]
async fn assets_files(req: HttpRequest) -> HttpResponse {
    let filename: String = req.match_info().query("filename").parse().unwrap();
    let path = format!("./assets/{}", filename);

    return HttpResponse::Ok()
        .content_type("text/html")
        .body(include_str!(&path));
}