variable "folder_id" {
  type        = string
  description = "ID of the folder where the project will be created under."
}

variable "project_name" {
  type        = string
  description = "Name of the GCP project."
}

variable "project_id" {
  type        = string
  description = "Name of the GCP project id. ex: my-test-project"
}

variable "billing_account" {
  type        = string
  description = "Alpha numeric id of the billing account. ex: 111111-111111-111111"
}

variable "enabled_service_apis" {
  type = set(string)

  default = [
    "serviceusage.googleapis.com",
    "artifactregistry.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]

  desctiption = "List of service apis to enable for the project (access to specific resources) https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service."
}
