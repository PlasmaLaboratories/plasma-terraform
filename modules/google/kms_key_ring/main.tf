resource "google_kms_key_ring" "keyring" {
  project  = var.project_id
  name     = var.key_ring_name
  location = var.key_location

  lifecycle {
    prevent_destroy = true
  }
}
