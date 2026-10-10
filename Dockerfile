# Build stage
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Create dedicated portwise user and data directory with full write permissions
RUN addgroup -S portwise && adduser -S portwise -G portwise \
    && mkdir -p /app/data \
    && chown -R portwise:portwise /app

COPY --from=builder --chown=portwise:portwise /app/target/portwise-backend-*.jar app.jar

USER portwise:portwise

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]
