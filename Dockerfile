# Etapa de construcción
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa de empaquetado (runtime)
FROM openjdk:26-ea-19-jdk-slim-trixie
WORKDIR /app
# Copia el JAR de la etapa 'build' a la etapa actual
COPY --from=build /app/target/AM.jar AM.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","AM.jar"]