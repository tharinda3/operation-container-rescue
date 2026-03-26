package main

import (
    "fmt"
    "net/http"
    "os"
)

func main() {
    hostname, _ := os.Hostname()
    
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Kubernetes! Pod: %s FLAG{K1ND_D3PLOY3R}", hostname)
    })
    
    fmt.Println("Server starting on :8080")
    http.ListenAndServe(":8080", nil)
}
