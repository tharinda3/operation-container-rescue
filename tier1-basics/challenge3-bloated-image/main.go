package main

import (
    "encoding/base64"
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        flagBytes, _ := base64.StdEncoding.DecodeString("RkxBR3tNVUxUMV9TVDRNM19OMU5KNH0=")
        fmt.Fprintf(w, "Slim and trim! %s", string(flagBytes))
    })

    fmt.Println("Server starting on :8080")
    http.ListenAndServe(":8080", nil)
}
