# syntax = docker/dockerfile:1.0-experimental
FROM golang:1.14-alpine as builder
ARG APP_VERSION
WORKDIR app/
COPY . .
RUN go build -ldflags "-s -w -X main.AppVersion=$APP_VERSION" -o /go-http-api ./src/cmd/api

FROM alpine:3.12
LABEL name="go-http-api"
COPY --from=builder /go-http-api /
CMD ["/go-http-api"]
