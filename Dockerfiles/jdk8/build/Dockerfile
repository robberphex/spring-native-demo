# docker build . -f Dockerfiles/build/Dockerfile -t build
FROM registry.ap-northeast-1.aliyuncs.com/luyanbo/graalvm-ce:ol8-java8-21.0.0.2-native-image

ADD . /build/
WORKDIR /build/

RUN ./mvnw -ntp -DskipTests compile package

RUN ls /build/target/



