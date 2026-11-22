#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${DEPLOYMENT_ENV:-development}"
STATUS="${DEPLOYMENT_STATUS:-unknown}"
VERSION="${DEPLOYMENT_VERSION:-unknown}"
COMMIT="${GITHUB_SHA:-local}"

echo "=================================="
echo "       DEPLOYMENT SUMMARY"
echo "=================================="
echo "Environment : $ENVIRONMENT"
echo "Status      : $STATUS"
echo "Version     : $VERSION"
echo "Commit      : ${COMMIT:0:7}"
echo "=================================="

if [[ "$STATUS" == "success" ]]; then
    echo "Deployment completed successfully."
elif [[ "$STATUS" == "failure" ]]; then
    echo "Deployment failed. Please investigate."
elif [[ "$STATUS" == "rolled-back" ]]; then
    echo "Deployment failed. Previous release restored."
else
    echo "Deployment status is unknown."
fi
