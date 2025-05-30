#!CMD: make container-build && make container-push
#!CMD: make container-build && make container-inspect
FROM golang:1.24.2 AS builder

COPY ./webserver /build
COPY ./app /build/app
WORKDIR /build

RUN go mod download

ARG BUILDARGS=""
ENV CGO_ENABLED=0
ENV BUILDENV="GOOS=linux"

RUN go build ${BUILDARGS} -ldflags '-extldflags "-static"' -o zeit

# ---

FROM scratch

LABEL \
	org.opencontainers.image.source="https://github.com/arch-err/zeit" \
	org.opencontainers.image.url="https://github.com/arch-err/zeit" \
	org.opencontainers.image.documentation="https://github.com/arch-err/zeit/README.md" \
	org.opencontainers.image.title="Zeit - Just a Simple Timer" \
	org.opencontainers.image.description="I just want a decent timer/stopwatch that doesn't look like shit, and that's got all of the features I want. That's all this is." \
	org.opencontainers.image.authors="arch-err archer@jesber.xyz"

COPY --from=builder /build/ /

EXPOSE 8080
ENTRYPOINT ["/zeit"]
