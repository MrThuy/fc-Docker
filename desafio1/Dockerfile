FROM golang:latest as builder

WORKDIR /app

COPY . .

RUN go build main.go

FROM scratch
WORKDIR /app
COPY --from=builder /app/ .
CMD ["./main"]

