#!/bin/sh
set -e

# Default PORT to 8080 if not provided by the environment (Render sets PORT at runtime)
PORT="${PORT:-8080}"

echo "Starting localb2b-ai-marketplace with PORT=${PORT}"
echo "JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"

exec java -Dserver.port=${PORT} $JAVA_TOOL_OPTIONS -jar /app/target/localb2b-ai-marketplace.jar
