#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SOURCE_FILE="${ROOT_DIR}/app/index.html"
DEPLOY_DIR="${ROOT_DIR}/mock-deployment"

APP_VERSION="${APP_VERSION:-1.0}"
BUILD_NUMBER="${BUILD_NUMBER:-local}"
COMMIT_SHA="${GITHUB_SHA:-local}"

SHORT_SHA="${COMMIT_SHA:0:7}"

RELEASE_VERSION="v${APP_VERSION}.${BUILD_NUMBER}-${SHORT_SHA}"

VERSION_DIR="${DEPLOY_DIR}/${RELEASE_VERSION}"

echo "Starting mock deployment..."
echo "Release version: ${RELEASE_VERSION}"

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: Application file not found!"
    exit 1
fi

mkdir -p "$VERSION_DIR"

cp "$SOURCE_FILE" "${VERSION_DIR}/index.html"

echo "$RELEASE_VERSION" > "${VERSION_DIR}/version.txt"

echo "Application deployed successfully."
echo "Deployment directory: ${VERSION_DIR}"
echo "Mock deployment completed!"
echo "$RELEASE_VERSION" > "${DEPLOY_DIR}/latest-version.txt"
