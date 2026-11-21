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

# Find the previous available release.
PREVIOUS_VERSION=""

for version_path in "$DEPLOY_DIR"/v*; do
    [[ -d "$version_path" ]] || continue

    VERSION="$(basename "$version_path")"

    if [[ "$VERSION" != "$CURRENT_VERSION" ]]; then
        PREVIOUS_VERSION="$VERSION"
    fi
done

if [[ -z "$PREVIOUS_VERSION" ]]; then
    echo "Rollback failed: No previous release found!"
    exit 1
fi

if [[ ! -f "${DEPLOY_DIR}/${PREVIOUS_VERSION}/index.html" ]]; then
    echo "Rollback failed: Previous release artifact is missing!"
    exit 1
fi

echo "$PREVIOUS_VERSION" > "$VERSION_FILE"

echo "Rollback successful!"
echo "Restored release: $PREVIOUS_VERSION"
