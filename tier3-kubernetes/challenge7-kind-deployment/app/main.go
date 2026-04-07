package main

import (
    "encoding/base64"
    "fmt"
    "net/http"
    "os"
)

func main() {
    hostname, _ := os.Hostname()

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        flagBytes, _ := base64.StdEncoding.DecodeString("RkxBR3tLMU5EX0QzUExPWTNSfQ==")
        fmt.Fprintf(w, "Hello from Kubernetes! Pod: %s %s", hostname, string(flagBytes))
    })

    fmt.Println("Server starting on :8080")
    http.ListenAndServe(":8080", nil)
}
