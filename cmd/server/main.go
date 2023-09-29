package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

func init() {
	if err := godotenv.Load(); err != nil {
		log.Fatal(err)
	}
}

func main() {
	s := &http.Server{
		Addr: fmt.Sprintf(":%s", os.Getenv("PORT")),
	}

	if err := s.ListenAndServe(); err != nil {
		log.Fatal(err)
	}
}
