FROM golang:1.19-alpine AS builder

WORKDIR /src

COPY . .
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o ./app ./main.go
#RUN go get -d -v

FROM scratch
COPY --from=builder /src/app /go/bin/app

EXPOSE 8080
LABEL Name=as4Shorty Version=0.0.1
ENTRYPOINT ["/go/bin/app"]
