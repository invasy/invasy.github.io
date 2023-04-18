FROM debian:bullseye-slim

ARG HUGO_VARIANT='hugo_extended'
ARG HUGO_VERSION='latest'
ARG SASS_VERSION='latest'
ARG PAGEFIND_VERSION='latest'
ARG GO_VERSION='1.20.3'
ARG _CONTAINER_USER='hugo'

COPY install.sh /tmp/
RUN bash /tmp/install.sh && rm -rf /tmp/*

USER "$_CONTAINER_USER"

ENV GOROOT='/opt/go' GOPATH="/home/$_CONTAINER_USER/go"
ENV GOBIN="$GOPATH/bin"
ENV PATH="$GOBIN:$GOROOT/bin:$PATH"

CMD ["hugo"]
