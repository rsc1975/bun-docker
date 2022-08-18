ARG GLIBC_RELEASE=2.34-r0
ARG release=latest

FROM alpine:latest as get-latest

WORKDIR /tmp
# get bun latest reelase
ADD https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip bun-linux-x64.zip

FROM alpine:latest as get-canary

WORKDIR /tmp
# get bun canary release
ADD https://github.com/oven-sh/bun/releases/download/canary/bun-linux-x64.zip bun-linux-x64.zip

FROM get-${release} as get-release

RUN apk --no-cache add unzip

RUN unzip bun-linux-x64.zip && chmod +x ./bun-linux-x64/bun

# get glibc
ARG GLIBC_RELEASE
RUN wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_RELEASE}/glibc-${GLIBC_RELEASE}.apk


### FINAL IMAGE ###
FROM alpine:latest as final

LABEL author="Roberto <https://hub.docker.com/u/dvlprtech>"
LABEL os="alpine"
LABEL github="https://github.com/rsc1975/bun-docker"
LABEL description="Image that provides bun (https://bun.sh/) runtime"

ARG GLIBC_RELEASE

COPY --from=get-release /tmp/bun-linux-x64/bun /usr/local/bin/ 

COPY --from=get-release /tmp/sgerrand.rsa.pub /etc/apk/keys
COPY --from=get-release /tmp/glibc-${GLIBC_RELEASE}.apk /tmp

# install glibc
RUN apk --no-cache add /tmp/glibc-${GLIBC_RELEASE}.apk && \
# cleanup
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm /tmp/glibc-${GLIBC_RELEASE}.apk && \
# smoke test
    bun --version

RUN echo -e '#!/bin/sh\n\
set -e\n\
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then\n\
  set -- bun "$@"\n\
fi\n\
exec "$@"\n ' > /entrypoint.sh
RUN chmod +x /entrypoint.sh 

ENTRYPOINT [ "/entrypoint.sh" ]
