FROM golang:1.22-alpine3.20 AS build

LABEL org.opencontainers.image.source=https://github.com/Makeshift/action-label-syncer

WORKDIR /go/src/app
COPY go.mod go.sum ./
RUN go mod download

COPY . /go/src/app
RUN go build -o /go/bin/app cmd/action-label-syncer/main.go

FROM gcr.io/distroless/base
COPY --from=build /go/bin/app /
CMD ["/app"]
