# Stage 1: Build the JAR
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR
FROM eclipse-temurin:17-jdk
COPY --from=build /build/server/launcher/target/plaato-*.jar app.jar
#COPY ./dataTeste /data
EXPOSE 8080 9443 8440
ENTRYPOINT ["java", "-jar", "app.jar", "-dataFolder", "/data"]