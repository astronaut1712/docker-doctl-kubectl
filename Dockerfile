FROM golang:1.15-alpine AS builder

RUN apk update && apk add --no-cache git

RUN go get -u github.com/digitalocean/doctl/cmd/doctl
RUN go get -u github.com/kubernetes/kubernetes/cmd/kubectl

FROM alpine:3.12
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/doctl .
COPY --from=builder /go/bin/kubectl .
RUN apk --update add git less openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

CMD ["./kubectl"]
