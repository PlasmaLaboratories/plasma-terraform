variable "project_id" {
  type        = string
  description = "The project id where the OIDC provider, pool, and service account will be created under."
}

variable "folder_name" {
  type        = string
  description = "The folder name used to assign permissions for the OIDC service account at a folder level."
}

variable "account_id" {
  type        = string
  default     = "oidc-service-account"
  description = "Optional Account ID for the OIDC service account."
}

variable "repo_attribute" {
  type        = string
  description = "Attribute for the OIDC mapping."
}

variable "project_roles" {
  type = set(string)

  default = [
    "roles/storage.admin",
    "roles/artifactregistry.repoAdmin"
  ]

  description = "List of Google Cloud roles set at a project level."
}

variable "folder_roles" {
  type = set(string)

  default = []

  description = "List of Google Cloud roles set at a folder level."
}
