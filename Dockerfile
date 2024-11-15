# # 使用官方的 OpenJDK 17 镜像作为基础镜像
# FROM maven:3.9.9-amazoncorretto-17-alpine as builder

# USER root

# # 设置工作目录
# WORKDIR /app

# # 这里假设使用 Maven，你可以根据需要调整为 Gradle
# COPY pom.xml .
# # 复制项目源代码
# COPY src ./src

# # 构建项目（可以替换为 Gradle 构建命令）
# RUN mvn clean package -DskipTests
# RUN JAR_FILE=$(mvn help:evaluate -Dexpression=project.build.finalName -q -DforceStdout).jar

# 使用 JRE 运行时环境作为运行镜像
FROM openjdk:17-alpine
USER root
# 设置工作目录
WORKDIR /app
# 从 builder 镜像中复制构建好的 JAR 文件到运行时镜像
COPY ./app.jar /app/app.jar
COPY ./config.json /app/config.json
COPY ./config.json /config.json

EXPOSE 8080

# 设置 JVM 参数，可以根据需要调整
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
