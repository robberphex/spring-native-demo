# docker build . -f Dockerfiles/jdk11/build/Dockerfile -t build
FROM graalvm-ce:java11-21.0.0.2-native-image

ADD . /build/
WORKDIR /build/

RUN ./mvnw -ntp -DskipTests clean compile package

RUN ls /build/target/
