FROM golang:1.15-alpine AS builder

RUN go get -u github.com/digitalocean/doctl/cmd/doctl
RUN go get -u github.com/kubernetes/kubernetes/cmd/kubectl

FROM alpine:3.12
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/* .

CMD ["./kubectl"]
