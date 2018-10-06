FROM golang:latest as builder 
RUN mkdir -p /go/src/github.com/ropnop/myinvoicer
ADD . /go/src/github.com/ropnop/myinvoicer
WORKDIR /go/src/github.com/ropnop/myinvoicer
RUN go build --ldflags '-extldflags "-static"' .

FROM busybox:latest
RUN addgroup --gid 10001 app
RUN adduser -G app -u 10001 -h /app -s /bin/false -D app

RUN mkdir -p /app/statics/
ADD statics /app/statics/
USER app
COPY --from=builder /go/src/github.com/ropnop/myinvoicer/myinvoicer /app/
EXPOSE 8080
WORKDIR /app
ENTRYPOINT /app/myinvoicer
