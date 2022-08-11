[![Last Commit](https://img.shields.io/github/last-commit/rsc1975/bun-docker?logo=github)](https://github.com/rsc1975/bun-docker/commits/main)
[![Docker version](https://img.shields.io/docker/v/dvlprtech/bun?sort=semver&logo=docker)](https://hub.docker.com/r/dvlprtech/bun)

# Docker image for bun

Based on alpine linux, the building process is fired when a new [version of bun](https://github.com/oven-sh/bun/releases/tag/bun-v0.1.8) is detected.

The image [dvlprtech/bun](https://hub.docker.com/r/dvlprtech/bun) is generated in DockerHub 



## Getting started

```
docker run -it --rm dvlprtech/bun --version
```

```
echo 'console.log("Hello World !!");' > hi.js
docker run -it --rm -v$(pwd):/app dvlprtech/bun /app/hi.js
```

Yo can also use the image as base for your bun own project:

```dockerfile
#Dockerfile
FRON dvlprtech/bun:latest
...
```