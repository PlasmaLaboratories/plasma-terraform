resource "google_kms_key_ring" "keyring" {
  project = var.project_id
  name     = var.key_ring_name
  location = "global"
}

resource "google_kms_crypto_key" "asymmetric_key" {
	# checkov:skip=CKV_GCP_43: Asymmetric keys do not support rotation.
  name     = var.kms_key_name
  key_ring = google_kms_key_ring.keyring.id
  purpose  = var.purpose

  version_template {
    algorithm = var.algorithm
  }

  lifecycle {
    prevent_destroy = true
  }
}
