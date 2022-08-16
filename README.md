[![Last Commit](https://img.shields.io/github/last-commit/rsc1975/bun-docker?logo=github)](https://github.com/rsc1975/bun-docker/commits/main)
[![Docker version](https://img.shields.io/docker/v/dvlprtech/bun?sort=semver&logo=docker)](https://hub.docker.com/r/dvlprtech/bun)
[![Docker image](https://img.shields.io/docker/image-size/dvlprtech/bun?logo=docker&sort=semver)](https://hub.docker.com/r/dvlprtech/bun)


# Docker image for bun

Based on [alpine linux](https://hub.docker.com/_/alpine), the building process is fired when a new [version of bun](https://github.com/oven-sh/bun/releases) is detected and a scheduled daily image based on bun `canary` version

* On new `bun` version, tags created: `latest` and `x.y.z`
* Scheduled daily on bun canary, tag created: `canary`

The image [dvlprtech/bun](https://hub.docker.com/r/dvlprtech/bun) is published  in DockerHub 



## Getting started

```sh
docker run -it --rm dvlprtech/bun --version
```
It will output for instance:
```txt
0.1.8
```

To launch a local file we need to map the file dir to the container:

```sh
echo 'console.log(`Hello ${process.argv[process.argv.length - 1] || "World"} !!`);' > hi.js
docker run -it --rm -v$(pwd):/app dvlprtech/bun run /app/hi.js Folks
```
It will show:
```
Hello Folks !!
```

Yo can also use the image as base for your bun own project:

```dockerfile
#Dockerfile
FRON dvlprtech/bun:latest
...
```
