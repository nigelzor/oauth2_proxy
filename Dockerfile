FROM golang:1.8

WORKDIR /go/src/github.com/bitly/oauth2_proxy
COPY . .

RUN go-wrapper download
RUN CGO_ENABLED=0 go-wrapper install

FROM alpine
RUN apk add --no-cache ca-certificates

COPY --from=0 /go/bin/oauth2_proxy /bin

ENTRYPOINT ["oauth2_proxy"]
