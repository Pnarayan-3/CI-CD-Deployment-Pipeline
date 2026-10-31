variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "terraform-cicd-demo"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"

  validation {
    condition = contains(
      ["development", "staging", "production"],
      var.environment
    )
    error_message = "Environment must be development, staging, or production."
  }
}