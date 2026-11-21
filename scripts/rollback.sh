#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="${ROOT_DIR}/mock-deployment"
VERSION_FILE="${DEPLOY_DIR}/latest-version.txt"

echo "Starting rollback..."

if [[ ! -f "$VERSION_FILE" ]]; then
    echo "Rollback failed: No current deployment found!"
    exit 1
fi

CURRENT_VERSION="$(cat "$VERSION_FILE")"

if [[ ! -d "$DEPLOY_DIR" ]]; then
    echo "Rollback failed: Deployment directory not found!"
    exit 1
fi

# Find the most recently modified release other than the current one.
PREVIOUS_VERSION=""

while IFS= read -r VERSION; do
    if [[ "$VERSION" != "$CURRENT_VERSION" ]]; then
        PREVIOUS_VERSION="$VERSION"
        break
    fi
done < <(
    find "$DEPLOY_DIR" -mindepth 2 -maxdepth 2 \
        -type f -name "index.html" \
        -printf '%T@ %h\n' |
    sort -nr |
    awk '{n=split($2,a,"/"); print a[n]}'
)

if [[ -z "$PREVIOUS_VERSION" ]]; then
    echo "Rollback failed: No previous release found!"
    exit 1
fi

PREVIOUS_FILE="${DEPLOY_DIR}/${PREVIOUS_VERSION}/index.html"

if [[ ! -f "$PREVIOUS_FILE" ]]; then
    echo "Rollback failed: Previous release artifact is missing!"
    exit 1
fi

echo "$PREVIOUS_VERSION" > "$VERSION_FILE"

echo "Rollback successful!"
echo "Previous release: $PREVIOUS_VERSION"
echo "Current release: $PREVIOUS_VERSION"
