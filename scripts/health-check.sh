#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="${ROOT_DIR}/mock-deployment"

VERSION_FILE="${DEPLOY_DIR}/latest-version.txt"

echo "Starting deployment health check..."

if [[ ! -f "$VERSION_FILE" ]]; then
    echo "Health check failed: Version file not found!"
    exit 1
fi

RELEASE_VERSION="$(cat "$VERSION_FILE")"
DEPLOYED_FILE="${DEPLOY_DIR}/${RELEASE_VERSION}/index.html"

if [[ ! -f "$DEPLOYED_FILE" ]]; then
    echo "Health check failed: Deployed application not found!"
    exit 1
fi

if ! grep -q "Terraform CI/CD Pipeline" "$DEPLOYED_FILE"; then
    echo "Health check failed: Expected application content missing!"
    exit 1
fi

echo "Health check passed!"
echo "Verified release: ${RELEASE_VERSION}"
