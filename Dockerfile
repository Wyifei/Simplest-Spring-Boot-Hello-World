# 
# Build stage.
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
VOLUME /tmp 
COPY --from=build /home/app/target/example.smallest-0.0.1-SNAPSHOT.war /tmp/example.war
EXPOSE 8080 
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/tmp/example.war"]

