FROM golang:alpine as builder
WORKDIR /app
COPY . .
RUN ls -la
RUN go build ./cmd/main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
CMD ["./main"]
