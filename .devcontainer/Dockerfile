FROM ghcr.io/gohugoio/hugo:v0.165.0

USER root
RUN sed -i '/^hugo:/s#:/sbin/nologin$#:/bin/sh#' /etc/passwd

WORKDIR /workspaces/blog-config

USER hugo:hugo
ENTRYPOINT []
