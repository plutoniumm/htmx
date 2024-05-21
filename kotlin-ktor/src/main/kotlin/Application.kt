package com.example

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.html.*
import io.ktor.server.http.content.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.io.*
import kotlinx.html.*

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.configureTemplating() {
    routing {
        val data =
                listOf(
                        listOf(
                                "Ktor",
                                "https://ktor.io/",
                                "https://resources.jetbrains.com/storage/products/company/brand/logos/Ktor_icon.png"
                        ),
                        listOf(
                                "HTMX",
                                "https://htmx.org/docs",
                                "https://htmx.org/img/htmx_logo.2.png"
                        ),
                )
        get("/details") {
            call.respondHtml {
                body {
                    h1 { +"Welcome to HTMX!" }
                    p { +"You're using these tools, check their docs to learn more:" }
                    ul {
                        for ((name, href, img) in data) {
                            li {
                                img(src = img)
                                a(href = href) { +name }
                            }
                        }
                    }
                }
            }
        }
    }
}

fun Application.configureRouting() {
    routing {
        staticFiles("/assets", File("assets"))
        get("/") { call.respondFile(File("index.html")) }
    }
}

fun Application.module() {
    configureTemplating()
    configureRouting()
}
