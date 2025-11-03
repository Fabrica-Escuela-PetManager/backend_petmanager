FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

COPY . .

# Si usas Maven
RUN ./mvnw clean package -DskipTests

# Si usas Gradle sería:
# RUN ./gradlew build -x test

FROM eclipse-temurin:17-jre

WORKDIR /app

# copia el jar generado
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
