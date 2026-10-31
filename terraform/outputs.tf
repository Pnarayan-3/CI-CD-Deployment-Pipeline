output "application_name" {
  description = "Application name"
  value       = var.app_name
}

output "deployment_environment" {
  description = "Deployment environment"
  value       = var.environment
}

output "deployment_file" {
  description = "Path of the generated deployment artifact"
  value       = local_file.deployment_artifact.filename
}