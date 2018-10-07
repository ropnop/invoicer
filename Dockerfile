FROM busybox:latest
RUN addgroup --gid 10001 app
RUN adduser -G app -u 10001 -h /app -s /bin/false -D app

RUN mkdir -p /app/statics/
ADD statics /app/statics/
USER app
COPY /go/src/github.com/ropnop/myinvoicer/invoicer /app/
EXPOSE 8080
WORKDIR /app
ENTRYPOINT /app/invoicer
