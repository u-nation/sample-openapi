FROM adoptopenjdk/openjdk8:alpine-slim

RUN apk add --no-cache git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
