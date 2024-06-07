# Test Swift avec Docker

WIP

Swift to test with a Docker

## Reproduce

Init with `swift package init --type executable`

## Usage

```sh
  cd Sources
  swift run server
```

### Build

Debug: 
`swift build`

Release: 
`swift build -c release`

### Remove build artefact

`swift package clean`

### Remove build directory

`swift package reset`

### Build for Linux
```sh
podman run --rm \
  -v "$PWD:/workspace" \
  -w /workspace \
  <SWIFT_DOCKER_IMAGE>  \
  /bin/bash -cl ' \
     swift build && \
     rm -rf .build/install && mkdir -p .build/install && \
     cp -P .build/debug/NIOHTTP1Server .build/install/ && \
     cp -P /usr/lib/swift/linux/lib*so* .build/install/'
```

```sh
podman run --rm \
  -v "$PWD:/workspace" \
  -w /workspace \
  swift:5.10  \
  /bin/bash -cl ' \
     swift build && \
     rm -rf .build/install && mkdir -p .build/install && \
     cp -P .build/release/server .build/install/ && \
     cp -P /usr/lib/swift/linux/lib*so* .build/install/'
```

## Deploy a Docker image
Dockerfile example:
```sh
# 1
## <OPTIONAL_ARCHITECTURE>/swift:<TAG_VERSION>
#FROM swift:5.10.0
FROM amd64/swift:5.10.0
WORKDIR /app
COPY . .

# 2
#RUN apt-get update && apt-get install libsqlite3-dev

# 3
RUN swift package clean
RUN swift build

# 4
RUN mkdir /app/bin
RUN mv `swift build --show-bin-path` /app/bin

# 5
EXPOSE 9080
#ENTRYPOINT ./bin/debug/Run serve --env local --hostname 0.0.0.0
ENTRYPOINT ./bin/debug/server
```

First build it:
`podman build . -tag <TAG>`

Then save it:
`podman save -o <OUTPUT_FILE> localhost/<TAG>`

Send to the server:
`scp <OUTPUT_FILE> <USERNAME>@<HOST>:~/`

Add it to local podman instance:
`podman load -i <OUTPUT_FILE>`

Finally run it:
`podman run -d --rmi -p 9080:9080 localhost/<TAG>`

__Remark__:
The <TAG> is saved in the saved imaged, that's why we are using the same value from one machine to another

__Remark__:
In the Dockerfile, the image used is base on `amd64` architecture because the targer server.

# Reference
[Swift Programming Language Book](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)

[Swift on Server](https://www.swift.org/documentation/server/)

(https://www.swift.org/documentation/server/guides/packaging.html)

(https://www.swift.org/documentation/server/guides/deploying/ubuntu.html)

(https://www.kodeco.com/26322368-developing-and-testing-server-side-swift-with-docker-and-vapor?page=2#toc-anchor-007)

[Use of FoundationNetworking framework for Linux instead of Foundation](https://github.com/apple/swift-corelibs-foundation/blob/main/Docs/ReleaseNotes_Swift5.md):
Some types and related have been split out of `Foundation` framework (only for Linux - MacOS still find those types in `Foundation`).
