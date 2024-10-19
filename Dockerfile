# Build stage
FROM gradle:jdk17 AS build

WORKDIR /app

# Copy the Gradle project files
COPY build.gradle settings.gradle ./
COPY gradlew ./
COPY gradle ./gradle
COPY src ./src

# Build the application
RUN ./gradlew build --no-daemon

# Run stage
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]

