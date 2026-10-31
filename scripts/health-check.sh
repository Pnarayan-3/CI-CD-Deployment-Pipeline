
#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DEPLOYED_FILE="${ROOT_DIR}/mock-deployment/index.html"

echo "Starting deployment health check..."

# Check whether deployed file exists
if [[ ! -f "$DEPLOYED_FILE" ]]; then
    echo "Health check failed: Deployed file not found!"
    exit 1
fi

# Verify application content
if ! grep -q "Terraform CI/CD Pipeline" "$DEPLOYED_FILE"; then
    echo "Health check failed: Expected application content missing!"
    exit 1
fi

echo "Health check passed!"
echo "Mock deployment is healthy."
