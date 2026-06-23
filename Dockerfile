# ---------------------------------------------------------
# Stage 1: Build the application
# ---------------------------------------------------------
# Use Eclipse Temurin JDK 17 as the base image for building
FROM eclipse-temurin:17-jdk-jammy AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven wrapper scripts and the .mvn directory
# This allows building the project without having Maven pre-installed
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file to download dependencies
COPY pom.xml .

# Make the Maven wrapper executable (in case file permissions were lost)
RUN chmod +x ./mvnw

# Download dependencies (this step is cached if pom.xml doesn't change)
RUN ./mvnw dependency:go-offline -B

# Copy the actual project source code
COPY src src

# Build the application, skipping tests to speed up the process
RUN ./mvnw clean package -DskipTests

# ---------------------------------------------------------
# Stage 2: Run the application
# ---------------------------------------------------------
# Use Eclipse Temurin JDK 17 for the runtime environment.
# Note: JDK is used instead of JRE because JSP compilation by embedded Tomcat often requires the Java compiler (javac).
FROM eclipse-temurin:17-jdk-jammy

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled executable JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 (the default Spring Boot port)
EXPOSE 8080

# Specify the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
