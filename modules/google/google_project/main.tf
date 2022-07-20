# GCP project definition.
resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

# Enable necessary project service apis.
resource "google_project_service" "service_apis" {
  for_each = var.enabled_service_apis

  project                    = google_project.project.id
  service                    = each.key
  disable_dependent_services = true
}
