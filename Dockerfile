# Use an official Maven image to build the application
FROM maven:3.6.3-openjdk-17 AS builder

ENV MAVEN_CONFIG ""

# Set the working directory for the builder
WORKDIR /build

# Copy the pom.xml and download dependencies
COPY complete .

# Build the application
RUN /build/mvnw clean package --errors

# Use an official OpenJDK runtime as a parent image for the final image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built jar from the builder stage to the final image
COPY --from=builder /build/target/rest-service-complete-0.0.1-SNAPSHOT.jar app.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
