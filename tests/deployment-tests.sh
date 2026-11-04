#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="${ROOT_DIR}/mock-deployment"
DEPLOYED_FILE="${DEPLOY_DIR}/index.html"

PASS=0
FAIL=0

cleanup() {
    rm -rf "$DEPLOY_DIR"
}

trap cleanup EXIT

run_test() {
    local test_name="$1"
    shift

    echo "Running: $test_name"

    if "$@"; then
        echo "PASS: $test_name"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $test_name"
        FAIL=$((FAIL + 1))
    fi

    echo "---------------------------------"
}

test_deployment_creates_file() {
    bash "${ROOT_DIR}/scripts/deploy.sh"
    test -f "$DEPLOYED_FILE"
}

test_deployment_copies_correct_content() {
    grep -q "Terraform CI/CD Pipeline" "$DEPLOYED_FILE"
}

test_health_check_passes() {
    bash "${ROOT_DIR}/scripts/health-check.sh"
}

test_health_check_detects_missing_file() {
    rm -f "$DEPLOYED_FILE"

    if bash "${ROOT_DIR}/scripts/health-check.sh"; then
        echo "Error: Health check should have failed!"
        return 1
    else
        echo "Expected failure detected successfully."
        return 0
    fi
}

echo "Starting Deployment Script Tests"
echo "================================"

run_test "Deployment creates application file" \
    test_deployment_creates_file

run_test "Deployment copies correct content" \
    test_deployment_copies_correct_content

run_test "Health check passes for valid deployment" \
    test_health_check_passes

run_test "Health check fails when deployed file is missing" \
    test_health_check_detects_missing_file

echo ""
echo "================================"
echo "Test Summary"
echo "Passed: $PASS"
echo "Failed: $FAIL"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi

echo "All deployment tests passed!"
