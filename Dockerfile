FROM ghcr.io/gohugoio/hugo:v0.165.0

WORKDIR /src
COPY . .
RUN hugo --gc --minify --environment production

EXPOSE 1313
CMD ["server", "--bind", "0.0.0.0"]
