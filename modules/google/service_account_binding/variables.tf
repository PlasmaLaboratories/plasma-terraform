variable "project_id" {
  type        = string
  description = "The project id where the OIDC provider, pool, and service account will be created under."
}

variable "service_account_name" {
  type        = string
  description = "Name of the service account. google_service_account.name."
}

variable "members" {
  type = set(string)

  description = "Users to bind service account to."
}

variable "roles" {
  type = set(string)

  default = [
    "roles/iam.workloadIdentityUser"
  ]

  description = "List of Google Cloud roles to set when binding service account."
}
