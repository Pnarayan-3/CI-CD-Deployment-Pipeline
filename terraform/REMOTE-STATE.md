
# Terraform Remote State

## Current Setup

This project currently uses Terraform local state.

## Future AWS Setup

The project will use an Amazon S3 backend for remote
state management.

## Backend Configuration

- Backend: Amazon S3
- Region: ap-south-1
- State key: terraform-cicd-demo/terraform.tfstate
- Encryption: Enabled
- State locking: S3 native lockfile

## Benefits

1. Centralized state storage.
2. Easier collaboration.
3. State locking.
4. Better CI/CD integration.

## Current Limitation

AWS resources are not provisioned because this project
currently uses a local Terraform provider.
