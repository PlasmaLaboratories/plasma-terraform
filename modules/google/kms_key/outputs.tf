output "id" {
  description = "ID of KMS key"
  value       = google_kms_crypto_key.asymmetric_key.id
}
