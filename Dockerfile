FROM eclipse-temurin:17-jdk
RUN apt-get update && apt-get install -y maven
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
EXPOSE 10000
ENV JAVA_TOOL_OPTIONS="-Xms128m -Xmx384m -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError"
CMD ["java","-Xms128m","-Xmx384m","-jar","/app/target/localb2b-ai-marketplace.jar"]