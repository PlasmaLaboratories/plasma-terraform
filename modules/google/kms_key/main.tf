resource "google_kms_crypto_key" "key" {
  # checkov:skip=CKV_GCP_43: False positive
  name     = var.kms_key_name
  key_ring = var.key_ring_id
  purpose  = var.purpose

  rotation_period = var.purpose == "ENCRYPT_DECRYPT" ? var.rotation_period : null

  version_template {
    algorithm = var.algorithm
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "key_binding" {
  crypto_key_id = google_kms_crypto_key.key.id

  role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = var.service_account_bindings
}
