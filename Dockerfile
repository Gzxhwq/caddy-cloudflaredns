# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM caddy:builder-alpine AS builder

ARG TARGETOS TARGETARCH

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
