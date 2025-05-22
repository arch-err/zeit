package main

import (
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"log"
	"os"
)

func main() {
	dir := os.Getenv("APP_DIR")
	if dir == "" {
		dir = "./app"
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	_, err := os.Stat(dir)
	if os.IsNotExist(err) {
		log.Fatalf("[!] Error: Directory not found: %s", dir)
	} else if err != nil {
		log.Fatalf("[!] Error accessing directory %s: %v", dir, err)
	}

	e := echo.New()
	e.Use(middleware.Logger())

	e.Static("/", dir)

	listenAddr := ":" + port
	log.Printf("[-] Serving directory %s on 0.0.0.0%s", dir, listenAddr)

	e.Logger.Fatal(e.Start(listenAddr))
}
