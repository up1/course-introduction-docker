package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		name, _ := os.Hostname()
		fmt.Fprintf(w, "V3 Hello, %q on %v", html.EscapeString(r.URL.Path), name)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))

}
