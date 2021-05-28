FROM golang:1.16-alpine AS build

ENV CGO_ENABLED=0
ENV GOOS=linux

RUN apk add --no-cache \
  git && \
  git clone https://github.com/gohugoio/hugo.git && \
  cd hugo && \
  go install

FROM scratch
COPY --from=build /go/bin/hugo /hugo
ENTRYPOINT [ "/hugo" ]
CMD [ "--help" ]
