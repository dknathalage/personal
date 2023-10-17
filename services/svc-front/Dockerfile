FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build ./cmd/main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
CMD ["./main"]
