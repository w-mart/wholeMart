#!/bin/sh
set -e

# Default PORT to 8080 if not provided by the environment (Render sets PORT at runtime)
PORT="${PORT:-8080}"
# Internal app port for the JVM to bind to (so we can open the external PORT early via socat)
APP_PORT="${APP_PORT:-10001}"

echo "Starting localb2b-ai-marketplace proxy: external PORT=${PORT} -> app PORT=${APP_PORT}"
echo "JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS}"

# Start a simple TCP proxy that listens on the external PORT and forwards to the internal APP_PORT.
# Socat will keep the external port open immediately so Render's port scanner can detect it.
socat TCP-LISTEN:${PORT},reuseaddr,fork TCP:127.0.0.1:${APP_PORT} &

# Start the JVM bound to APP_PORT in the foreground.
exec java -Dserver.port=${APP_PORT} $JAVA_TOOL_OPTIONS -jar /app/target/localb2b-ai-marketplace.jar
