FROM debian:bullseye-slim

# Container annotations
# See https://github.com/opencontainers/image-spec/blob/main/annotations.md#annotations
LABEL org.opencontainers.image.title="Hugo"
LABEL org.opencontainers.image.description="Static site generator"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.source="https://github.com/invasy/invasy.github.io"
LABEL org.opencontainers.image.url="https://github.com/invasy/invasy.github.io/pkgs/container/hugo"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
LABEL org.opencontainers.image.authors="Vasiliy Polyakov <docker@invasy.dev>"
LABEL org.opencontainers.image.vendor="Vasiliy Polyakov <docker@invasy.dev>"
LABEL maintainer="Vasiliy Polyakov <docker@invasy.dev>"

# Requirements
ARG HUGO_VARIANT="hugo_extended"
ARG HUGO_VERSION="0.114.1"
ARG GO_VERSION="1.20.5"
ARG SASS_VERSION="1.63.6"
ARG PAGEFIND_VERSION="0.12.0"
ARG HADOLINT_VERSION="2.12.0"

# User settings
ARG _CONTAINER_USER="hugo"
ARG USER_NAME="$_CONTAINER_USER"
ARG USER_PASSWORD="1"
ARG USER_COMMENT="Hugo"
ARG ROOT_PASSWORD="1"

# Copy installation script
COPY --chmod=755 install.sh /tmp/

# Create and setup user
RUN set -eu;\
    /tmp/install.sh user "$USER_NAME" -p "$USER_PASSWORD" -c "$USER_COMMENT";\
    /tmp/install.sh password root "$ROOT_PASSWORD"

# Install packags
RUN /tmp/install.sh packages -uU\
    bash-completion\
    ca-certificates\
    curl\
    git\
    jq\
    less\
    nodejs\
    npm\
    pandoc

# Install requirements
RUN /tmp/install.sh hadolint "$HADOLINT_VERSION"
RUN /tmp/install.sh go       "$GO_VERSION"
RUN /tmp/install.sh sass     "$SASS_VERSION"
RUN /tmp/install.sh pagefind "$PAGEFIND_VERSION"
RUN /tmp/install.sh hugo     "$HUGO_VERSION" "$HUGO_VARIANT"

# Clean up
RUN rm -rf /tmp/*

# Setup user environment
USER "$USER_NAME"
ENV GOROOT='/opt/go' GOPATH="/home/$USER_NAME/go"
ENV GOBIN="$GOPATH/bin"
ENV PATH="$GOBIN:$GOROOT/bin:$PATH"

ENTRYPOINT ["hugo"]
CMD []
