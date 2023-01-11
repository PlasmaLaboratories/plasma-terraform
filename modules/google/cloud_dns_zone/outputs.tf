output "dnssec_keys" {
  description = "DNSSEC keys"
  value       = var.dnssec_state == "on" ? data.google_dns_keys.keys[0].key_signing_keys[0].ds_record : null
  sensitive   = true
}
