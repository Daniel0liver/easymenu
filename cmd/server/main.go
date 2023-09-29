package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/daniel0liver/easymenu/internal/db"
	"github.com/joho/godotenv"
)

func init() {
	if err := godotenv.Load(); err != nil {
		log.Fatal(err)
	}
}

func main() {
	_, err := db.NewDB()
	if err != nil {
		log.Fatal(err)
	}

	s := &http.Server{
		Addr: fmt.Sprintf(":%s", os.Getenv("PORT")),
	}

	if err := s.ListenAndServe(); err != nil {
		log.Fatal(err)
	}
}
