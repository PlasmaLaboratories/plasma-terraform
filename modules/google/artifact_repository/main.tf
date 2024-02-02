provider "google" {
  project = var.project_id
  region  = var.location
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.location
  repository_id = var.repository_id
  description   = "Terraform generated docker repository."
  format        = var.format
  kms_key_name  = var.kms_key_name
}
