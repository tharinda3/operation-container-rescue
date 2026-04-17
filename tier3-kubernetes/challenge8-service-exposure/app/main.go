package main

import (
    "encoding/base64"
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        flagBytes, _ := base64.StdEncoding.DecodeString("RkxBR3szWFAwUzNEX1MzUlYxQzN9")
        fmt.Fprintf(w, "You reached me from outside! %s", string(flagBytes))
    })

    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        w.WriteHeader(http.StatusOK)
        fmt.Fprintf(w, "OK")
    })

    fmt.Println("Server starting on :8080")
    http.ListenAndServe(":8080", nil)
}
