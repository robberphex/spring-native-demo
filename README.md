# Spring Native Demo

Spring Native 可以构建可以通过 GraalVM 将 Spring 应用程序编译成原生镜像，提供了一种新的方式来部署 Spring 应用。

Spring Native 的目标是寻找 Spring JVM 的替代方案，提供一个能将应用程序打包，并运行在轻量级容器中的方案。期望能够在 Spring Native 中支持所有的 Spring 应用程序（几乎不用修改代码）。

## 优点

* 编译出来的原生 Spring 应用可以作为一个独立的可执行文件进行部署（不需要安装 JVM）
* 几乎瞬时的启动（一般小于 100 毫秒）
* 瞬时的峰值性能
* 更低的资源消耗

## 如何构建

1. 构建出native-image镜像（包含graalvm、msul-gcc）
```shell
docker build . -f Dockerfiles/jdk11/build/Dockerfile -t build
```
2. 构建出build镜像（包含代码以及构建好的二机制文件）
```shell
docker build . -f Dockerfiles/jdk11/build/Dockerfile -t build
```
3. 构建出package镜像（只包含最终的二进制文件）
```shell
docker build . -f Dockerfiles/jdk11/package/Dockerfile -t package
```

这样就得到了`package:latest`镜像，可以直接运行了：
```shell
docker run -p 8080:8080 package:latest
```
启动时间 1ms :
![](./img/startup.png)

可以访问接口验证下：
```shell
$ curl localhost:8080/
{"timestamp":"2021-04-14T08:28:42.099+00:00","status":404,"error":"Not Found","message":"","path":"/"}
$ curl localhost:8080/b
B[172.17.0.2]
$ curl localhost:8080/b-get-zone
B[当前 IP：4x.1xx.7x.9x  来自于：中国 XX XX  XXX]
```

当然，您可以通过Kubernetes方式来部署最终的镜像。
