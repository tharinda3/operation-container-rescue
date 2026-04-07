FROM golang:1.24 AS builder
WORKDIR /app
COPY main.go .
RUN CGO_ENABLED=0 go build -o server main.go

FROM alpine:3.20.2
COPY --from=builder /app/server /server
EXPOSE 8080
CMD ["/server"]
