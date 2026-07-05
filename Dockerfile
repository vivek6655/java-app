# Step 1: Use an official JDK image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy project files
COPY . .

# Build the Spring Boot JAR
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JRE image to run the app
# Use a valid Temurin JRE image (supports ARM64/AMD64)
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (default Spring Boot port)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
