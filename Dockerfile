# 使用官方的 OpenJDK 17 镜像作为基础镜像
FROM openjdk:17-jdk-slim as builder

USER root

# 设置工作目录
WORKDIR /app

# 将你的 Maven 或 Gradle 构建文件复制到工作目录
# 这里假设使用 Maven，你可以根据需要调整为 Gradle
COPY pom.xml .

# 下载依赖项，不进行编译，只为了缓存依赖
RUN mvn dependency:go-offline

# 复制项目源代码
COPY src ./src

# 构建项目（可以替换为 Gradle 构建命令）
RUN mvn clean package -DskipTests

# 使用 JRE 运行时环境作为运行镜像
FROM openjdk:17-jre-slim

# 设置工作目录
WORKDIR /app

# 从 builder 镜像中复制构建好的 JAR 文件到运行时镜像
COPY ./config.json /config.json
COPY --from=builder /app/target/*.jar /app/app.jar

# 暴露应用端口（通常 Spring Boot 默认端口为 8080）
EXPOSE 8080

# 设置 JVM 参数，可以根据需要调整
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
