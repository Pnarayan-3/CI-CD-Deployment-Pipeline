
#!/usr/bin/env bash

set -euo pipefail

# Find the project root directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Define source and deployment directories
SOURCE_FILE="${ROOT_DIR}/app/index.html"
DEPLOY_DIR="${ROOT_DIR}/mock-deployment"

echo "Starting mock deployment..."

# Check whether the application file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: Application file not found!"
    exit 1
fi

# Create deployment directory
mkdir -p "$DEPLOY_DIR"

# Copy application files
cp "$SOURCE_FILE" "$DEPLOY_DIR/index.html"

echo "Application copied successfully."
echo "Mock deployment completed!"
