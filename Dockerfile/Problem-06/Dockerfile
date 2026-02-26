#Create a Dockerfile to run a java-Maven Application
FROM alpine/git AS clone
WORKDIR /app
RUN git clone https://github.com/Code-with-Shravani25/java-maven-code.git

FROM maven:3.9.12-eclipse-temurin-17 AS builder
WORKDIR /app
COPY --from=clone /app/java-maven-code/. .
RUN mvn clean package

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]

#Runas : sudo docker run -d -p 8080:8080 <image>

#eclipse-temurin: it is a open source, production ready distribution of openjdk maintained by eclipse foundation, commonly used in Docker images for running java applicatoons.
