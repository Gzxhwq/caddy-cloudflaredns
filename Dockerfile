# syntax=docker/dockerfile:1

ARG TAG

FROM --platform=$BUILDPLATFORM caddy:$TAG-builder-alpine AS builder

ARG TARGETOS TARGETARCH

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH \
    xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/mholt/caddy-webdav

FROM caddy:$TAG-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
