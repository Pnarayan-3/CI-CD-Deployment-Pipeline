#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-development}"

case "$ENVIRONMENT" in
    development)
        APP_VERSION="1.0"
        DEPLOYMENT_ENV="development"
        ;;
    staging)
        APP_VERSION="1.0"
        DEPLOYMENT_ENV="staging"
        ;;
    production)
        APP_VERSION="1.0"
        DEPLOYMENT_ENV="production"
        ;;
    *)
        echo "Error: Invalid environment: $ENVIRONMENT"
        echo "Allowed: development, staging, production"
        exit 1
        ;;
esac

export APP_VERSION
export DEPLOYMENT_ENV

echo "Environment: $DEPLOYMENT_ENV"
echo "Application version: $APP_VERSION"
