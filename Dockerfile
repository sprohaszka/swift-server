# 1
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