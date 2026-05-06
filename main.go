package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", HandleHome)

	fmt.Println("Server listening on PORT:8080")
	if err := http.ListenAndServe(":8080", mux); err != nil {
		log.Fatal(err)
	}
}

func HandleHome(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, World!"))
}
