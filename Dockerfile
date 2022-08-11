FROM ubuntu:22.04 as get

RUN apt update && apt install -y unzip && apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

ADD https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip bun-linux-x64.zip
RUN unzip bun-linux-x64.zip 
RUN chmod +x ./bun-linux-x64/bun

FROM ubuntu:22.04 as build

COPY --from=get /tmp/bun-linux-x64/bun /usr/local/bin/bun

RUN echo '#!/bin/bash\n\
set -e\n\
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then\n\
  set -- bun "$@"\n\
fi\n\
exec "$@"\n ' > entrypoint.sh
RUN chmod +x entrypoint.sh 

ENTRYPOINT [ "/entrypoint.sh" ]
