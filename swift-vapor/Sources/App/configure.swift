import Leaf
import Vapor


func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Swift"])
    }

    app.get("details") { req async throws -> View in
        struct Project: Codable {
            let name: String
            let url: String
            let img: String
        }

        struct Data: Codable  {
            var data = [
                Project(name: "Vapor", url: "https://vapor.codes/docs", img: "https://docs.vapor.codes/assets/logo.png"),
                Project(name: "HTMX", url: "https://htmx.org/docs", img: "https://htmx.org/img/htmx_logo.2.png"),
                Project(name: "Leaf", url: "https://docs.vapor.codes/leaf/getting-started/", img: "https://docs.vapor.codes/assets/logo.png"),
            ]
        }

        return try await req.view.render("details", Data())
    }
}

// configures your application
public func configure(_ app: Application) async throws {
    app.http.server.configuration.port = 3000
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    try routes(app)
}
