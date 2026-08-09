FROM eclipse-temurin:17-jdk
RUN apt-get update && apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
EXPOSE 10000
CMD ["java","-jar","/app/target/localb2b-ai-marketplace.jar"]