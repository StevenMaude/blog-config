FROM ghcr.io/gohugoio/hugo:v0.165.0

WORKDIR /src
COPY . .

EXPOSE 1313
CMD ["server", "--bind", "0.0.0.0"]
