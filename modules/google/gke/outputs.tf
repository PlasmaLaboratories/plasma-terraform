output "ipv6_cidr_range" {
  description = "IPV6 Cidr Range"
  value       = google_compute_subnetwork.custom.ipv6_cidr_range
}

output "gateway_address" {
  description = "IPV6 Cidr Range"
  value       = google_compute_subnetwork.custom.gateway_address
}

output "external_ipv6_prefix" {
  description = "IPV6 Cidr Range"
  value       = google_compute_subnetwork.custom.external_ipv6_prefix
}
