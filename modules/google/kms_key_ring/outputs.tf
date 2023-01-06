output "key_ring_id" {
  description = "ID of KMS key ring"
  value       = google_kms_key_ring.keyring.id
}
