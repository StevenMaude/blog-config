FROM ghcr.io/gohugoio/hugo:v0.165.0 AS build

WORKDIR /src
COPY . .
RUN hugo --gc --minify --environment production

FROM nginx:1.29.1-alpine

COPY --from=build /src/public/ /usr/share/nginx/html/
EXPOSE 80
