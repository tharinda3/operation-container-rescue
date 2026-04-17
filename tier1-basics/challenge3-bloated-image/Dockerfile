# This image is way too big! Optimize me with multi-stage builds
FROM golang:1.21.0

WORKDIR /app

COPY main.go .

RUN go build -o server main.go

CMD ["./server"]
