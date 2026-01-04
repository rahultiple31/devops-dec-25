FROM eclipse-temurin:11-jre-alpine

WORKDIR /app

COPY target/*.jar web.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "web.jar"]
