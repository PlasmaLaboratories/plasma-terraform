output "dnssec_keys" {
  description = "DNSSEC keys"
  value = data.google_dns_keys.keys.key_signing_keys[0].ds_record
  sensitive = true
}
