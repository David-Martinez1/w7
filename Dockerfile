FROM openjdk:17-oracle

USER root

COPY ./config.json /config.json
COPY ./target/ds-lab01-1.0-SNAPSHOT-jar-with-dependencies.jar /httpserv/w7-1.0-SNAPSHOT-jar-with-dependencies.jar

ENTRYPOINT ["java", "-jar", "./httpserv/w7-1.0-SNAPSHOT-jar-with-dependencies.jar"]
