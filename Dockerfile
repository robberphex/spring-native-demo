# https://github.com/orgs/graalvm/packages/container/graalvm-ce/versions
FROM ghcr.io/graalvm/graalvm-ce:java11-21.0.0.2 as build

RUN gu install native-image

RUN gu list

# BEGIN PRE-REQUISITES FOR STATIC NATIVE IMAGES FOR GRAAL 20.2.0
# SEE: https://github.com/oracle/graal/blob/master/substratevm/StaticImages.md
ARG RESULT_LIB="/staticlibs"

RUN mkdir ${RESULT_LIB} && \
    curl -L -o musl.tar.gz https://musl.libc.org/releases/musl-1.2.1.tar.gz && \
    mkdir musl && tar -xvzf musl.tar.gz -C musl --strip-components 1 && cd musl && \
    ./configure --disable-shared --prefix=${RESULT_LIB} && \
    make && make install && \
    cd / && rm -rf /muscl && rm -f /musl.tar.gz && \
    cp /usr/lib/gcc/x86_64-redhat-linux/8/libstdc++.a ${RESULT_LIB}/lib/

ENV PATH="$PATH:${RESULT_LIB}/bin"
ENV CC="musl-gcc"

RUN curl -L -o zlib.tar.gz https://zlib.net/zlib-1.2.11.tar.gz && \
   mkdir zlib && tar -xvzf zlib.tar.gz -C zlib --strip-components 1 && cd zlib && \
   ./configure --static --prefix=${RESULT_LIB} && \
    make && make install && \
    cd / && rm -rf /zlib && rm -f /zlib.tar.gz
#END PRE-REQUISITES FOR STATIC NATIVE IMAGES FOR GRAAL 20.2.0

RUN microdnf install maven

ADD . /build/
WORKDIR /build/

RUN --mount=type=cache,target=/root/.m2 mvn -B -DskipTests clean compile package

RUN ls /build/target/

FROM alpine:3.13

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk add curl iproute2

COPY --from=build /build/target/demo /app/demo

CMD ["/app/demo"]

