# Build from the root of the repo:
#   docker build -t root101-landing .
# Run:
#   docker run -p 8080:80 root101-landing
#
# A static site: no backend, no env.js. nginx serves the Flutter build (same image as the
# consoles of feather-io and dumpling).

FROM debian:trixie-slim AS build

# Bump it with .fvmrc
ARG FLUTTER_VERSION=3.47.1

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl git unzip xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Only the tag of the version (not the whole history) and only the web artifacts
RUN git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter config --no-analytics --no-cli-animations \
    && flutter precache --web --no-android --no-ios --no-linux --no-windows --no-macos

WORKDIR /src

# Resolve dependencies (cached while the pubspec doesn't change)
COPY pubspec.* ./
RUN flutter pub get --enforce-lockfile

# Copy the source (except anything in .dockerignore) and build
COPY . .
# CanvasKit from the build itself, not from Google's CDN: the CSP only allows scripts of the origin
RUN flutter build web --release --no-web-resources-cdn

# Static files on nginx
FROM nginx:1.29.1-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/security_headers.conf /etc/nginx/security_headers.conf
COPY --from=build /src/build/web /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://127.0.0.1/health || exit 1
