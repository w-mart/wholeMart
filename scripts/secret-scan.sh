#!/usr/bin/env bash
set -euo pipefail

# Basic secret scan: search for JWT secret and common secret keywords in repo
echo "Running basic secret scan..."

# files to scan
files=$(git ls-files)

issues=0
for pattern in "jwt-secret" "JWT_SECRET" "password:" "apiKey" "api_key" "secret:"; do
  if grep -RIn --line-number --exclude-dir=.git --exclude-dir=target --exclude=*.class "$pattern" >/dev/null 2>&1; then
    echo "[WARN] Found occurrences of pattern '$pattern'"
    grep -RIn --line-number --exclude-dir=.git --exclude-dir=target --exclude=*.class "$pattern" || true
    issues=$((issues+1))
  fi
done

if [ "$issues" -gt 0 ]; then
  echo "Secret scan completed: potential issues found. Please inspect results above."
  exit 1
fi

echo "Secret scan completed: no obvious secrets found."
