provider "google" {
  project = var.project_id
}

resource "google_dns_managed_zone" "zone" {
  name        = var.zone_name
  dns_name    = var.dns_name
  description = var.description

  dnssec_config {
    state = var.dnssec_state
  }
}

data "google_dns_keys" "keys" {
  count        = var.dnssec_state == "on" ? 1 : 0
  managed_zone = google_dns_managed_zone.zone.id
}
