FROM golang:1.16-alpine3.14 as builder
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN go build -o main .

FROM alpine:3.14
COPY --from=builder /build/main /
ENTRYPOINT ["/main"]
