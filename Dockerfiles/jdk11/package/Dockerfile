# docker build . -f Dockerfiles/jdk11/package/Dockerfile -t package
FROM build:latest as build

FROM alpine:3.13

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk add curl vim iproute2

COPY --from=build /build/target/com.example.demo.demoapplication /app/com.example.demo.demoapplication

CMD ["/app/com.example.demo.demoapplication"]
