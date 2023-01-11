# GCP project definition.
resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = false
}

# Enable necessary project service apis.
resource "google_project_service" "service_apis" {
  for_each = var.enabled_service_apis

  project                    = google_project.project.id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_project_iam_audit_config" "project_audit" {
  project = google_project.project.id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
