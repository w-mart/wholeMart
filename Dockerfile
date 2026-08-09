FROM eclipse-temurin:17-jdk
RUN apt-get update && apt-get install -y maven curl
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests
# Render injects the runtime port via the PORT env var (defaults to 8080).
EXPOSE 8080
ENV JAVA_TOOL_OPTIONS="-Xms128m -Xmx384m -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError"
# Use a small entrypoint script so we can log the runtime PORT and pass it to the JVM.
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh
# Healthcheck will probe the local actuator health endpoint using the runtime PORT.
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://127.0.0.1:${PORT:-8080}/actuator/health || exit 1
ENTRYPOINT ["/app/docker-entrypoint.sh"]
