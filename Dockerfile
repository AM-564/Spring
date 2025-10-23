# Etapa de construcción (Java 21)
FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn -B clean package -DskipTests

# Etapa de ejecución (Java 21 JRE/JDK)
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/AM.jar AM.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","AM.jar"]