FROM build:latest as build

FROM debian:10-slim

COPY --from=build /build/target/com.example.demo.demoapplication /app/com.example.demo.demoapplication

CMD ["/app/com.example.demo.demoapplication"]
