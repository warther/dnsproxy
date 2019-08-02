FROM golang:1.12-stretch AS builder

ADD . /dnsproxy

RUN cd /dnsproxy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo . && strip ./dnsproxy

FROM scratch

COPY --from=builder /dnsproxy/dnsproxy .

entrypoint ["./dnsproxy -l 127.0.0.1 --https-port=443 --tls-crt=warth.ml.crt --tls-key=warth.ml.key -u 1.1.1.1:53"]
