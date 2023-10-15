package main

import (
	"context"
	"fmt"
	"net/http"
	"os"

	"github.com/a-h/templ"
	"github.com/labstack/echo/v4"
)

func render(component templ.Component) string {
	templBuffer := templ.GetBuffer()
	defer templ.ReleaseBuffer(templBuffer)
	ctx := templ.InitializeContext(context.Background())
	err := component.Render(ctx, templBuffer)
	if err != nil {
		panic(err)
	}
	return templBuffer.String()
}

func main() {
	e := echo.New()

	var PORT string
	if len(os.Args) > 1 {
		PORT = os.Args[1]
	} else {
		PORT = "3000"
	}

	e.Static("/assets", "assets")
	e.File("/", "index.html")
	e.GET("/details", func(c echo.Context) error {
		return c.HTML(http.StatusOK, render(details()))
	})

	fmt.Println("Listening on port " + PORT)
	http.ListenAndServe(":3000", e)
}
