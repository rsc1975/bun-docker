FROM ubuntu:22.04

RUN apt update && apt install -y curl unzip && apt clean && rm -rf /var/lib/apt/lists/*


RUN curl https://bun.sh/install | bash

ENV BUN_INSTALL="/root/.bun"
ENV PATH="$BUN_INSTALL/bin:$PATH"

RUN echo '#!/bin/bash\n\
set -e\n\
if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then\n\
  set -- bun "$@"\n\
fi\n\
exec "$@"\n ' > entrypoint.sh
RUN chmod +x entrypoint.sh 

ENTRYPOINT [ "/entrypoint.sh" ]
